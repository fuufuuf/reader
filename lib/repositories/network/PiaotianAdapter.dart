import 'package:built_collection/built_collection.dart';
import 'package:html/dom.dart';

import 'package:timnew_reader/features/App/common.dart';
import 'package:timnew_reader/repositories/network/ReaderHttpClient.dart';
import 'package:timnew_reader/repositories/network/SiteAdapter.dart';
import 'package:timnew_reader/repositories/network/ParseExtensions.dart';

import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/BookInfo.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/models/NewBook.dart';

class PiaotianAdapter extends SiteAdapter {
  static const String adapterName = "piaotian";

  PiaotianAdapter(ReaderHttpClient client) : super(client);

  static final chapterListPathPattern = RegExp(r"/html/(\d+)/(\d+)/(index.html)?", caseSensitive: false);

  static final chapterContentPathPattern = RegExp(r"/html/(\d+)/(\d+)/(\d+).html", caseSensitive: false);

  @override
  bool canParse(Uri url) => url.host.safeEqual('www.ptwxz.com');

  @override
  Future<BookInfo> fetchBookInfo(BookIndex bookIndex) async {
    final document = await client.fetchDom(bookIndex.bookInfoUrl);

    final metaCells = document
            .querySelectorAll('#content > table > tbody > tr > td > table[cellpadding="3"]')
            ?.first
            ?.querySelectorAll('tr > td') ??
        {userError("頁面結構錯，無法找到書籍信息")};

    return BookInfo(
      bookIndex: bookIndex,
      genre: _extractMeta(metaCells, 2, '类    别：'),
      author: _extractMeta(metaCells, 3, '作    者：'),
      length: _extractMeta(metaCells, 5, '全文长度：'),
      lastUpdated: _extractMeta(metaCells, 6, '最后更新：'),
      completeness: _extractMeta(metaCells, 7, '文章状态：'),
    );
  }

  String _extractMeta(List<Element> metaCells, int index, String toBeRemoved) =>
      metaCells[index]?.text?.remove(toBeRemoved)?.trim();

  @override
  Future<ChapterList> fetchChapterList(BookIndex bookIndex) async {
    final document = await client.fetchDom(bookIndex.chapterListUrl);

    final List<Element> chapterListElements =
        document.querySelectorAll('.mainbody .centent ul li a') ?? {userError("頁面結構錯誤, 無法找到章節信息容器")};

    return ChapterList(
      bookIndex: bookIndex,
      chapters: chapterListElements
          .map((element) => _buildChapterRef(bookIndex, bookIndex.chapterListUrl, element))
          .toBuiltList(),
    );
  }

  ChapterRef _buildChapterRef(BookIndex bookIndex, Uri base, Element element) => ChapterRef(
        bookIndex: bookIndex,
        url: element.href().asAbsoluteUri(base).enforceHttps() ?? {userError("無效的章節連結 ${element.text}")},
        title: element.text,
      );

  @override
  Future<ChapterContent> fetchChapterContent(BookIndex bookIndex, Uri url) async {
    final document = await client.fetchDom(url, patchHtml: _bypassAntiScrape);

    return ChapterContent(
      bookIndex: bookIndex,
      url: url,
      title: document.querySelector('h1').text.trim() ?? {userError("頁面結構錯誤，無法找到標題")},
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
      paragraphs: document.getElementById('content').notEmptyTextChildrenAsParagraphs(),
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

    if (url.pathSegments.first.safeEqual("bookinfo")) {
      satisfy(url.pathSegments.length == 3) ?? userError("無效的書目首頁鏈接 $url");
      return newBookFromBookInfo(url);
    }

    satisfy(url.pathSegments.first.safeEqual("html")) ?? userError("無效的書目鏈接 $url");

    satisfy(url.pathSegments.length == 3 || url.pathSegments.length == 4) ?? userError("無效的書目鏈接 $url");

    if (url.pathSegments.length == 3 ||
        url.pathSegments.last.safeEqual("index.html") ||
        url.pathSegments.last.isEmpty) {
      return newBookFromChapterList(url);
    }

    return newBookFromChapterContent(url);
  }

  Future<NewBook> newBookFromBookInfo(Uri url) async {
    final document = await client.fetchDom(url);

    return NewBook(
      adapter: adapterName,
      bookId: _extractBookId(url),
      bookName: document.querySelector('h1')?.text?.trim() ?? userError("頁面結構錯誤，無法找到書名"),
      bookInfoUrl: url,
      chapterListUrl: "https://www.ptwxz.com/html/${_extractBookIdPath(url)}/".asUri(),
    );
  }

  Future<NewBook> newBookFromChapterList(Uri url) async {
    final document = await client.fetchDom(url);

    return NewBook(
      adapter: adapterName,
      bookId: _extractBookId(url),
      bookName: document.querySelector('.title h1')?.text?.trim()?.remove("最新章节") ?? userError("頁面結構錯誤，無法找到書名"),
      bookInfoUrl: "https://www.ptwxz.com/bookinfo/${_extractBookIdPath(url)}.html".asUri(),
      chapterListUrl: url,
    );
  }

  Future<NewBook> newBookFromChapterContent(Uri url) async {
    final document = await client.fetchDom(url, patchHtml: _bypassAntiScrape);

    final Element bookTitleAElement = document.querySelector('h1 > a') ?? {userError("頁面結構錯誤, 無法找到標題信息")};

    return NewBook(
      adapter: adapterName,
      bookId: _extractBookId(url),
      bookName: bookTitleAElement.text.trim(),
      bookInfoUrl: bookTitleAElement.href().asUri().enforceHttps(),
      chapterListUrl: "https://www.ptwxz.com/html/${_extractBookIdPath(url)}/".asUri(),
      currentChapterUrl: url,
    );
  }

  String _extractBookId(Uri url) => _extractBookIdPath(url).replaceAll("/", "-");

  String _extractBookIdPath(Uri url) => "${url.pathSegments[1]}/${url.pathSegments[2].remove(".html")}";
}
