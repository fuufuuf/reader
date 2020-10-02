import 'package:html/dom.dart';
import 'package:timnew_reader/models/BookInfo.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/models/NewBook.dart';
import 'package:timnew_reader/repositories/network/ReaderHttpClient.dart';
import 'package:timnew_reader/repositories/network/SiteAdapter.dart';
import 'package:timnew_reader/repositories/network/safeExtractors.dart';

class PiaotianAdapter extends SiteAdapter {
  PiaotianAdapter(ReaderHttpClient client) : super(client);

  static final bookUrlPattern = RegExp(r"https?://www.ptwxz.com/bookinfo/(\d+)/(\d+).html", caseSensitive: false);

  static final chapterListUrlPattern =
      RegExp(r"https?://www.ptwxz.com/html/(\d+)/(\d+)/(index.html)?", caseSensitive: false);

  static final chapterContentUrlPattern =
      RegExp(r"https?://www.ptwxz.com/html/(\d+)/(\d+)/(\d+).html", caseSensitive: false);

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

    return 'piaotian-${match.group(1)}-${match.group(2)}';
  }

  @override
  Future<BookInfo> fetchBookInfo(Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return BookInfo((b) => b
      ..url = url
      ..bookId = _extractBookId(url)
      ..chapterListUrl = Uri.parse(url.toString().replaceFirst("/bookinfo/", "/html/").replaceFirst(".html", "/"))
      ..title = document.querySelector('h1').text.trim()
      ..author = safeText(() => _extractMeta(document, 3, '作    者：'))
      ..genre = safeText(() => _extractMeta(document, 2, '类    别：'))
      ..completeness = safeText(() => _extractMeta(document, 7, '文章状态：'))
      ..lastUpdated = safeText(() => _extractMeta(document, 6, '最后更新：'))
      ..length = safeText(() => _extractMeta(document, 5, '全文长度：')));
  }

  String _extractMeta(Document document, int index, String toRemove) => document
      .querySelectorAll('#content > table > tbody > tr > td > table[cellpadding="3"]')
      .first
      .querySelectorAll('tr > td')[index]
      .text
      .trim()
      .replaceAll(toRemove, '');

  @override
  Future<ChapterList> fetchChapterList(Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return ChapterList((b) => b
      ..url = url
      ..title = safeText(() => document.querySelector('.title h1')?.text?.trim()?.replaceAll("最新章节", ""))
      ..bookInfoUrl = safeUrl(url, () => document.querySelectorAll('#tl > a')[1].attributes['href'])
      ..chapters.addAll(safeList(
          () => document.querySelectorAll('.mainbody .centent ul li a').map((element) => ChapterRef((crb) => crb
            ..url = url.resolve(element.attributes['href'])
            ..title = element.text)))));
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
