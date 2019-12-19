import 'package:html/dom.dart';
import 'package:timnew_reader/models/CurrentBook.dart';
import 'package:timnew_reader/models/book_models.dart';

import 'ReaderHttpClient.dart';
import 'SiteAdapter.dart';
import 'safeExtractors.dart';

class PiaotianAdapter extends SiteAdapter {
  PiaotianAdapter(ReaderHttpClient client) :super(client);

  static final bookUrlPattern = RegExp(
      r"https?://www.ptwxz.com/bookinfo/(\d+)/(\d+).html",
      caseSensitive: false);

  static final chapterListUrlPattern = RegExp(
      r"https?://www.ptwxz.com/html/(\d+)/(\d+)/(index.html)?",
      caseSensitive: false);

  static final chapterContentUrlPattern = RegExp(
      r"https?://www.ptwxz.com/html/(\d+)/(\d+)/(\d+).html",
      caseSensitive: false);

  @override
  Future<Type> fetchResourceType(Uri url) async {
    var urlString = url.toString();

    if (chapterContentUrlPattern.hasMatch(urlString)) {
      return ChapterContent;
    }

    if (chapterListUrlPattern.hasMatch(urlString)) {
      return ChapterRef;
    }

    if (bookUrlPattern.hasMatch(urlString)) {
      return BookInfo;
    }

    throw "Unknown Url: $url";
  }

  String _extractBookId(Uri bookInfoUrl) {
    final match = bookUrlPattern.firstMatch(bookInfoUrl.toString());

    return 'piaotian-${ match.group(1)}-${match.group(2)}';
  }

  @override
  Future<CurrentBook> fetchBookInfo(Uri url, CurrentBook currentBook) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return currentBook.rebuild((b) {
      if (!currentBook.hasBookIndex) {
        b.bookIndex
          ..id = _extractBookId(url)
          ..title = document
              .querySelector('h1')
              .text
              .trim()
          ..bookInfoUrl = url
          ..chapterListUrl = Uri.parse(
              url
                  .toString()
                  .replaceFirst("/bookinfo/", "/html/")
                  .replaceFirst(".html", "/")
          );
      }
      b.bookInfo
        ..author = safeText(() =>
            _extractMeta(document, 3, '作    者：')
        )
        ..genre = safeText(() =>
            _extractMeta(document, 2, '类    别：')
        )
        ..completeness = safeText(() =>
            _extractMeta(document, 7, '文章状态：')
        )
        ..lastUpdated = safeText(() =>
            _extractMeta(document, 6, '最后更新：')
        )
        ..length = safeText(() =>
            _extractMeta(document, 5, '全文长度：')
        );
    });
  }

  String _extractMeta(Document document, int index, String toRemove) =>
      document
          .querySelectorAll(
          '#content > table > tbody > tr > td > table[cellpadding="3"]')
          .first
          .querySelectorAll('tr > td')[index]
          .text
          .trim()
          .replaceAll(toRemove, '');


  @override
  Future<CurrentBook> fetchChapterList(Uri url, CurrentBook currentBook) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return currentBook.rebuild((b) {
      if (!currentBook.hasBookIndex) {
        final bookInfoUrl = safeUrl(url,
                () => document.querySelectorAll('#tl > a')[1].attributes['href']
        );

        b.bookIndex
          ..id = _extractBookId(bookInfoUrl)
          ..title = safeText(() =>
              document
                  .querySelector('.title h1')
                  ?.text
                  ?.trim()
                  ?.replaceAll("最新章节", ""))
          ..bookInfoUrl = bookInfoUrl
          ..chapterListUrl = url;
      }

      b.chapterList
        ..replace(safeList(() =>
            document
                .querySelectorAll('.mainbody .centent ul li a')
                .map((element) =>
                ChapterRef(
                        (crb) =>
                    crb
                      ..url = url.resolve(element.attributes['href'])
                      ..title = element.text
                )
            )));
    });
  }

  @override
  Future<CurrentBook> fetchChapterContent(Uri url,
      CurrentBook currentBook) async {
    final document = await client.fetchDom(
        url, enforceGbk: true, patchHtml: (html) =>
        html.replaceFirst(
            '<script language="javascript">GetFont();</script>',
            '<div id="content">'));

    final titleParts = safeText(() =>
    document
        .querySelector('h1')
        .text
    ).split(" ");

    return currentBook.rebuild((b) {
      if (!currentBook.hasBookIndex) {
        final bookInfoUrl = safeUrl(url, () =>
        document
            .querySelectorAll('.toplink > a')[3]
            .attributes['href']);

        b.bookIndex
          ..id = _extractBookId(bookInfoUrl)
          ..title = titleParts.first
          ..bookInfoUrl = bookInfoUrl
          ..chapterListUrl = safeUrl(url, () =>
          document
              .querySelectorAll('.toplink > a')[1]
              .attributes['href']);
      }

      b.chapter
        ..title = titleParts
            .getRange(titleParts.length - 2, titleParts.length )
            .join(" ")
        ..url = url;

      b.chapterContent
        ..previousChapterUrl = safeUrlWithPattern(
            url, chapterContentUrlPattern, () =>
        document
            .querySelectorAll('.toplink > a')[0]
            .attributes['href'])
        ..nextChapterUrl = safeUrlWithPattern(
            url, chapterContentUrlPattern, () =>
        document
            .querySelectorAll('.toplink > a')[2]
            .attributes['href'])
        ..paragraphs.replace(safeList(() =>
            document
                .getElementById('content')
                .nodes
                .where((node) => node.nodeType == Node.TEXT_NODE)
                .map((node) => node.text.trim())
                .where((text) => text.isNotEmpty)
                .map((text) => '    ' + text)
        ))
        ..isLocked = false;
    });
  }
}
