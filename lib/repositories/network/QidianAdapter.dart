import 'package:html/dom.dart';
import 'package:timnew_reader/features/App/UserException.dart';

import 'package:timnew_reader/models/BookInfo.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/models/NewBook.dart';
import 'package:timnew_reader/repositories/network/ReaderHttpClient.dart';
import 'package:timnew_reader/repositories/network/SiteAdapter.dart';
import 'package:timnew_reader/repositories/network/safeExtractors.dart';

class QidianAdapter extends SiteAdapter {
  QidianAdapter(ReaderHttpClient client) : super(client);

  static final bookUrlPattern = RegExp(r"https?://book.qidian.com/info/(\d+)", caseSensitive: false);

  static final chapterListUrlPattern = RegExp(r"https?://book.qidian.com/info/(\d+)#Catalog", caseSensitive: false);

  static final chapterContentUrlPattern = RegExp(r"https?://read.qidian.com/chapter/(\w+)/(\w+)", caseSensitive: false);

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

    throw UserException("無法解析的 Url: $url");
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

    throw UserException("無法解析的 Url: $url");
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

    return 'qidian-${match.group(1)}';
  }

  @override
  Future<BookInfo> fetchBookInfo(Uri url) async {
    final document = await client.fetchDom(url);

    return BookInfo(
      url: url,
      bookId: _extractBookId(url),
      chapterListUrl: url.replace(fragment: 'Catalog'),
      title: safeText(() => document.querySelector('.book-info > h1 > em').text),
      author: safeText(() => document.querySelector('.book-info .writer').text),
      genre: safeText(() => document.querySelector('.book-info a.red').text),
      completeness: safeText(() => document.querySelector('.book-info span.blue').text),
      lastUpdated: '',
      length: '',
    );
  }

  @override
  Future<ChapterList> fetchChapterList(Uri url) async {
    final document = await client.fetchDom(url);

    var title = safeText(() => document.querySelector('.book-info > h1 > em').text);

    return ChapterList(
      url: url,
      title: title,
      bookInfoUrl: url.replace(fragment: ''),
      chapters: _buildChapterList(document, url),
    );
  }

  Iterable<ChapterRef> _buildChapterList(Document document, Uri url) {
    return safeList(
        () => document.querySelectorAll('.volume ul.cf > li > a').map((element) => _buildChapterRef(url, element)));
  }

  ChapterRef _buildChapterRef(Uri url, Element element) {
    return ChapterRef(
      url: url.resolve(element.attributes['href']),
      title: element.text,
    );
  }

  @override
  Future<ChapterContent> fetchChapterContent(Uri url) async {
    final document = await client.fetchDom(url);

    final chapterControls = document.querySelectorAll('chapter-control > a');

    return ChapterContent((b) => b
      ..url = url
      ..title = safeText(() => document.querySelector('.j_chapterName').text)
      ..chapterListUrl = safeUrl(url, () => chapterControls[1].attributes['href'])
      ..previousChapterUrl = safeUrlWithPattern(
          url, chapterContentUrlPattern, () => document.querySelectorAll('chapter-control > a')[0].attributes['href'])
      ..nextChapterUrl = safeUrlWithPattern(
          url, chapterContentUrlPattern, () => document.querySelectorAll('chapter-control > a')[2].attributes['href'])
      ..paragraphs.addAll(safeList(() => document
          .getElementById('content')
          .nodes
          .where((node) => node.nodeType == Node.TEXT_NODE)
          .map((node) => node.text.trim())
          .where((text) => text.isNotEmpty)
          .map((text) => '    ' + text)))
      ..isLocked = document.querySelector('.vip - limit - wrap') != null);
  }
}
