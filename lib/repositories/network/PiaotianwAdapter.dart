import 'package:html/dom.dart';
import 'package:timnew_reader/models/BookInfo.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/models/NewBook.dart';
import 'package:timnew_reader/repositories/network/ReaderHttpClient.dart';
import 'package:timnew_reader/repositories/network/SiteAdapter.dart';
import 'package:timnew_reader/repositories/network/safeExtractors.dart';

class PiaotianwAdapter extends SiteAdapter {
  PiaotianwAdapter(ReaderHttpClient client) : super(client);

  static final bookUrlPattern = RegExp(r"https?://www.piaotianw.com/(\w+)/", caseSensitive: false);

  static final chapterListUrlPattern = RegExp(r"https?://www.piaotianw.com/(\w+)/", caseSensitive: false);

  static final chapterContentUrlPattern = RegExp(r"https?://www.piaotianw.com/(\w+)/(\d+).html", caseSensitive: false);

  @override
  Future<Type> fetchResourceType(Uri url) async {
    var urlString = url.toString();

    if (chapterContentUrlPattern.hasMatch(urlString)) {
      return ChapterContent;
    }

    if (chapterListUrlPattern.hasMatch(urlString)) {
      return ChapterList;
    }

    if (bookUrlPattern.hasMatch(urlString)) {
      return BookInfo;
    }

    throw Exception("無法解析的 Url: $url");
  }

  @override
  Future<NewBook> createBook(Uri url) async {
    final content = await fetchFromUrl(url);

    if (content is BookInfo) {
      return _buildBookEntryFromBookInfo(content);
    }

    if (content is ChapterList) {
      return _buildBookEntryFromChapterList(content);
    }

    if (content is ChapterContent) {
      return _buildBookEntryFromChapterContent(content);
    }

    throw Exception("無法解析的 Url: $url");
  }

  NewBook _buildBookEntryFromBookInfo(BookInfo bookInfo) => NewBook(
      bookId: _extractBookId(bookInfo.url),
      bookName: bookInfo.title,
      bookInfoUrl: bookInfo.url,
      chapterListUrl: bookInfo.chapterListUrl);

  NewBook _buildBookEntryFromChapterList(ChapterList list) => NewBook(
      bookId: _extractBookId(list.bookInfoUrl),
      bookName: list.title,
      bookInfoUrl: list.bookInfoUrl,
      chapterListUrl: list.url);

  Future<NewBook> _buildBookEntryFromChapterContent(ChapterContent content) async {
    return _buildBookEntryFromChapterList(await content.fetchChapterList())
        .rebuild((b) => b..currentChapterUrl = content.url);
  }

  String _extractBookId(Uri bookInfoUrl) {
    final match = bookUrlPattern.firstMatch(bookInfoUrl.toString());

    return 'piaotianw-${match.group(1)}';
  }

  @override
  Future<BookInfo> fetchBookInfo(Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return BookInfo((b) => b
      ..url = url
      ..bookId = _extractBookId(url)
      ..chapterListUrl = url
      ..title = safeText(() => document.querySelector('h1').text)
      ..author = safeText(() => _extractMeta(document, 0, '作    者：'))
      ..genre = ''
      ..completeness = ''
      ..lastUpdated = safeText(() => _extractMeta(document, 2, '最后更新：'))
      ..length = '');
  }

  String _extractMeta(Document document, int index, String toRemove) =>
      document.getElementById('info').querySelectorAll('p')[index].text.trim().replaceAll(toRemove, '');

  @override
  Future<ChapterList> fetchChapterList(Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return ChapterList((b) => b
      ..url = url
      ..title = safeText(() => document.querySelector('h1').text)
      ..bookInfoUrl = url
      ..chapters.addAll(safeList(() => _findChapters(document).map((element) => ChapterRef((crb) => crb
        ..url = url.resolve(element.attributes['href'])
        ..title = element.text)))));
  }

  List<Element> _findChapters(Document document) {
    final allNodes = document.getElementById('list').querySelector('dl').children;

    var caption = allNodes.lastIndexWhere((e) => e.localName == 'dt');

    return allNodes.sublist(caption + 1).map((e) => e.querySelector('a'));
  }

  @override
  Future<ChapterContent> fetchChapterContent(Uri url) async {
    final document = await client.fetchDom(url,
        enforceGbk: true,
        patchHtml: (html) =>
            html.replaceFirst('<script language="javascript">GetFont();</script>', '<div id="content">'));

    return ChapterContent((b) => b
      ..url = url
      ..title = safeText(() => document.querySelector('h1').text)
      ..chapterListUrl = safeUrl(url, () => document.querySelectorAll('.toplink > a')[1].attributes['href'])
      ..previousChapterUrl = safeUrlWithPattern(
          url, chapterContentUrlPattern, () => document.querySelectorAll('.toplink > a')[0].attributes['href'])
      ..nextChapterUrl = safeUrlWithPattern(
          url, chapterContentUrlPattern, () => document.querySelectorAll('.toplink > a')[2].attributes['href'])
      ..paragraphs.addAll(safeList(() => document
          .getElementById('content')
          .nodes
          .where((node) => node.nodeType == Node.TEXT_NODE)
          .map((node) => node.text.trim())
          .where((text) => text.isNotEmpty)
          .map((text) => '    ' + text)))
      ..isLocked = false);
  }
}
