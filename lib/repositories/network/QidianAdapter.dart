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
import 'package:timnew_reader/repositories/network/ParseExtensions.dart';

class QidianAdapter extends SiteAdapter {
  static const String adapterName = "qidian";

  QidianAdapter(ReaderHttpClient client) : super(client);

  // https://book.qidian.com/info/1016572786
  // https://book.qidian.com/info/1016572786#Catalog
  // https://read.qidian.com/chapter/XtIxtJwLQQA3v1oFI-DX8Q2/cjyJdr8Tw536ItTi_ILQ7A2
  // https://vipreader.qidian.com/chapter/1016572786/507165475

  @override
  bool canParse(Uri url) => url.host?.toLowerCase()?.endsWith(".qidian.com") ?? false;

  @override
  Future<BookInfo> fetchBookInfo(BookIndex bookIndex) async {
    final document = await client.fetchDom(bookIndex.bookInfoUrl);

    return BookInfo(
      bookIndex: bookIndex,
      author: document.querySelector('.book-info .writer').text?.trim(),
      genre: document.querySelector('.book-info a.red').text?.trim(),
      completeness: document.querySelector('.book-info span.blue').text?.trim(),
    );
  }

  @override
  Future<ChapterList> fetchChapterList(BookIndex bookIndex) async {
    final document = await client.fetchDom(bookIndex.chapterListUrl);

    final chapterListElements = document.querySelectorAll('.volume ul.cf > li > a') ?? userError("頁面結構錯誤，無法獲取章節清單");

    return ChapterList(
      bookIndex: bookIndex,
      chapters: chapterListElements.map((e) => _buildChapterRef(bookIndex, e)).toBuiltList(),
    );
  }

  ChapterRef _buildChapterRef(BookIndex bookIndex, Element element) {
    return ChapterRef(
      bookIndex: bookIndex,
      url: element.href()?.asUri() ?? userError("無法獲取章節鏈接 $element"),
      title: element.text?.trim() ?? userError("無法獲取章節名字 $element"),
    );
  }

  @override
  Future<ChapterContent> fetchChapterContent(BookIndex bookIndex, Uri url) async {
    final document = await client.fetchDom(url);

    final chapterTitle = document.querySelector('.j_chapterName').text.trim() ?? userError("頁面結構錯誤，無法獲取章節標題");

    // Element always exists, but with no href on first page.
    final previousChapterUrl = document.getElementById('j_chapterPrev').href()?.asAbsoluteUri(url)?.enforceHttps();

    // Element and href always exists, but link to different url on last page
    //read.qidian.com/chapter/ZrTmoA_1aYDdjrstIrF5-w2/cMN5gBOw6662uJcMpdsVgA2
    //read.qidian.com/lastpage/1023335251
    final nextChapterUrl = document
        .getElementById('j_chapterPrev')
        .href()
        ?.asAbsoluteUri(url)
        ?.enforceHttps()
        ?.nullIf((u) => u.pathSegments.first.safeEqual("lastpage"));

    final paragraphs = document.querySelectorAll('.read-content .content-wrap').asParagraphs();

    final isLocked = url.host.safeEqual("vipreader.qidian.com");

    return ChapterContent(
      bookIndex: bookIndex,
      url: url,
      title: chapterTitle,
      previousChapterUrl: previousChapterUrl,
      nextChapterUrl: nextChapterUrl,
      isLocked: isLocked,
      paragraphs: paragraphs,
    );
  }

  @override
  Future<NewBook> parseNewBook(Uri url) async {
    // https://book.qidian.com/info/1016572786
    // https://book.qidian.com/info/1016572786#Catalog
    // https://read.qidian.com/chapter/XtIxtJwLQQA3v1oFI-DX8Q2/cjyJdr8Tw536ItTi_ILQ7A2
    // https://vipreader.qidian.com/chapter/1016572786/507165475

    if (url.host.safeEqual("book.qidian.com")) {
      return newBookFromBookInfo(url);
    }
  }

  Future<NewBook> newBookFromBookInfo(Uri url) async {
    final document = await client.fetchDom(url);

    return NewBook(
      adapter: adapterName,
      bookId: _buildBookId(url),
      bookName: document.querySelector('.book-info > h1 > em')?.text?.trim() ?? userError("頁面結構錯誤, 無法解析書名"),
      bookInfoUrl: url,
      chapterListUrl: url,
    );
  }

  Future<NewBook> newBookFromChapterContent(Uri url) async {
    final document = await client.fetchDom(url);

    final bookInfoElement = document.querySelector('.info.fl > a') ?? userError("頁面結構錯誤，無法找到書目首頁鏈接");
    final bookInfoUrl =
        bookInfoElement.href()?.asUri()?.enforceHttps() ?? userError("頁面結構錯誤，無法獲取書目首頁鏈接 $bookInfoElement");

    return NewBook(
      adapter: adapterName,
      bookId: _buildBookId(bookInfoUrl),
      bookName: bookInfoElement?.text?.trim() ?? userError("頁面結構錯, 無法解析書名"),
      bookInfoUrl: bookInfoUrl,
      chapterListUrl: bookInfoUrl,
      currentChapterUrl: url,
    );
  }

  String _buildBookId(Uri url) => "$adapterName-${url.pathSegments[1]}";
}
