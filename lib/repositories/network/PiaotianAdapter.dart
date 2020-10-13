import 'package:built_collection/built_collection.dart';
import 'package:html/dom.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/BookInfo.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/models/NewBook.dart';
import 'package:timnew_reader/repositories/network/ReaderHttpClient.dart';
import 'package:timnew_reader/repositories/network/SiteAdapter.dart';
import 'package:timnew_reader/repositories/network/safeExtractors.dart';

class PiaotianAdapter extends SiteAdapter {
  static const String name = "piaotian";

  PiaotianAdapter(ReaderHttpClient client) : super(client);

  static final chapterListPathPattern = RegExp(r"/html/(\d+)/(\d+)/(index.html)?", caseSensitive: false);

  static final chapterContentPathPattern = RegExp(r"/html/(\d+)/(\d+)/(\d+).html", caseSensitive: false);

  @override
  bool canParse(Uri url) => url.host.safeEqual('www.ptwxz.com');

  @override
  Future<BookInfo> fetchBookInfo(BookIndex bookIndex) async {
    final document = await client.fetchDom(bookIndex.bookInfoUrl, enforceGbk: true);

    return BookInfo(
      bookIndex: bookIndex,
      author: _extractMeta(document, 3, '作    者：'),
      genre: _extractMeta(document, 2, '类    别：'),
      completeness: _extractMeta(document, 7, '文章状态：'),
      lastUpdated: _extractMeta(document, 6, '最后更新：'),
      length: _extractMeta(document, 5, '全文长度：'),
    );
  }

  String _extractMeta(Document document, int index, String toRemove) => document
      .querySelectorAll('#content > table > tbody > tr > td > table[cellpadding="3"]')
      .first
      .querySelectorAll('tr > td')[index]
      .text
      .replaceAll(toRemove, '')
      .trim();

  @override
  Future<ChapterList> fetchChapterList(BookIndex bookIndex) async {
    final document = await client.fetchDom(bookIndex.chapterListUrl, enforceGbk: true);

    return ChapterList(
      bookIndex: bookIndex,
      chapters: _buildChapters(bookIndex, document, bookIndex.chapterListUrl),
    );
  }

  BuiltList<ChapterRef> _buildChapters(BookIndex bookIndex, Document document, Uri url) => document
      .querySelectorAll('.mainbody .centent ul li a')
      .map((element) => _buildChapterRef(bookIndex, url, element))
      .toBuiltList();

  ChapterRef _buildChapterRef(BookIndex bookIndex, Uri base, Element element) => ChapterRef(
        bookIndex: bookIndex,
        url: element.href().asAbsoluteUri(base).enforceHttps() ?? {userError("無效的章節連結 ${element.text}")},
        title: element.text,
      );

  @override
  Future<ChapterContent> fetchChapterContent(BookIndex bookIndex, Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true, patchHtml: _bypassAntiScrape);

    return ChapterContent(
      bookIndex: bookIndex,
      url: url,
      title: document.querySelector('h1').text.trim() ?? "",
      previousChapterUrl: document
          .querySelectorAll('.toplink > a')[0]
          ?.href()
          ?.asAbsoluteUri(url)
          ?.enforceHttps()
          ?.nullIfPathNotMatch(chapterContentPathPattern),
      nextChapterUrl: document
          .querySelectorAll('.toplink > a')[2]
          ?.href()
          ?.asAbsoluteUri(url)
          ?.enforceHttps()
          ?.nullIfPathNotMatch(chapterContentPathPattern),
      paragraphs: document.getElementById('content').textNodesAsParagraphs().toBuiltList(),
    );
  }

  String _bypassAntiScrape(String html) =>
      html.replaceFirst('<script language="javascript">GetFont();</script>', '<div id="content">');

  @override
  Future<NewBook> parseNewBook(Uri url) async {
    // https://www.ptwxz.com/bookinfo/11/11014.html

    // https://www.ptwxz.com/html/11/11014/
    // https://www.ptwxz.com/html/11/11014/index.html

    // https://www.ptwxz.com/html/11/11014/7882142.html

    if (url.pathSegments.first.safeEqual("bookInfo")) {
      userAssert(url.pathSegments.length == 3, "無效的書目首頁鏈接 $url");
      return newBookFromBookInfo(url);
    }

    userAssert(url.pathSegments.first.safeEqual("html"), "無效的書目鏈接 $url");

    userAssert(url.pathSegments.length == 3 || url.pathSegments.length == 4, "無效的書目鏈接 $url");

    if (url.pathSegments.length == 3 || url.pathSegments.last.safeEqual("index.html")) {
      return newBookFromChapterList(url);
    }

    return newBookFromChapterContent(url);
  }

  Future<NewBook> newBookFromBookInfo(Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return NewBook(
      bookId: _bookId(url),
      bookName: document.querySelector('h1').text.trim(),
      bookInfoUrl: url,
      chapterListUrl: "https://www.ptwxz.com/html/${_bookIdPath(url)}/".asUri(),
    );
  }

  Future<NewBook> newBookFromChapterList(Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return NewBook(
      bookId: _bookId(url),
      bookName: document.querySelector('.title h1')?.text?.trim()?.replaceAll("最新章节", ""),
      bookInfoUrl: "https://www.ptwxz.com/bookinfo/${_bookIdPath(url)}.html".asUri(),
      chapterListUrl: url,
    );
  }

  Future<NewBook> newBookFromChapterContent(Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true, patchHtml: _bypassAntiScrape);

    final bookTitleAElement = document.querySelector('h1 > a');

    return NewBook(
      bookId: _bookId(url),
      bookName: bookTitleAElement.text.trim(),
      bookInfoUrl: bookTitleAElement.href().asUri().enforceHttps(),
      chapterListUrl: "https://www.ptwxz.com/html/${_bookIdPath(url)}/".asUri(),
      currentChapterUrl: url,
    );
  }

  String _bookId(Uri url) => "${url.pathSegments[1]}-${url.pathSegments[2]}";

  String _bookIdPath(Uri url) => "${url.pathSegments[1]}/${url.pathSegments[2]}";
}
