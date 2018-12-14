import 'package:html/dom.dart';
import 'package:reader/models/Book.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/models/TableOfContents.dart';
import 'package:reader/repositories/ReaderHttpClient.dart';
import 'package:reader/repositories/SiteAdapter.dart';
import 'package:reader/repositories/safeExtractors.dart';

class PiaotianAdapter extends SiteAdapter {
  PiaotianAdapter(ReaderHttpClient client) :super(client);

  static final bookUrlPattern = RegExp(
      r"https?://www.piaotian.com/bookinfo/(\d+)/(\d+).html",
      caseSensitive: false);

  static final menuUrlPattern = RegExp(
      r"https?://www.piaotian.com/html/(\d+)/(\d+)/(index.html)?",
      caseSensitive: false);

  static final chapterUrlPattern = RegExp(
      r"https?://www.piaotian.com/html/(\d+)/(\d+)/(\d+).html",
      caseSensitive: false);

  @override
  Future<Type> checkType(Uri url) async {
    var urlString = url.toString();

    if (chapterUrlPattern.hasMatch(urlString)) {
      return ChapterContent;
    }

    if (menuUrlPattern.hasMatch(urlString)) {
      return TableOfContents;
    }

    if (bookUrlPattern.hasMatch(urlString)) {
      return Book;
    }

    throw "Unknown Url: $url";
  }

  @override
  Future<Book> openBook(Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return Book(
      url: url,
      title: document.querySelector('h1').text.trim(),
      author: safeText(
              () =>
          document
              .querySelectorAll(
              '#content > table > tbody > tr > td > table[cellpadding="3"]')
              .first
              .querySelectorAll('tr > td')[3]
              .text
              .trim()
              .replaceAll("作    者：", "")
      ),
        menuUrl: Uri.parse(
            url.toString().replaceFirst("/bookinfo/", "/html/").replaceFirst(
                ".html", "/"))
    );
  }

  @override
  Future<TableOfContents> openMenu(Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return TableOfContents(
        url: url,
        title: safeText(() =>
            document
            .querySelector('.title h1')
                ?.text
                ?.trim()
                ?.replaceAll("最新章节", "")),
        bookUrl: safeUrl(url, () =>
        document.querySelectorAll('#tl > a')[1].attributes['href']
        ),
        chapters: safeList(() =>
            document
            .querySelectorAll('.mainbody .centent ul li a')
            .map((element) => ChapterRef(
                url: url.resolve(element.attributes['href']),
                title: element.text))
                .toList(growable: false)
        )
    );
  }

  @override
  Future<ChapterContent> openChapter(Uri url) async {
    final document = await client.fetchDom(
        url, enforceGbk: true, patchHtml: (html) =>
        html.replaceFirst(
            '<script language="javascript">GetFont();</script>',
            '<div id="content">'));

    return ChapterContent(
        url: url,
        title: safeText(() =>
        document
            .querySelector('h1')
            .text),
        bookUrl: safeUrl(url, () =>
        document
            .querySelectorAll('.toplink > a')[3]
            .attributes['href']),
        menuUrl: safeUrl(url, () =>
        document
            .querySelectorAll('.toplink > a')[1]
            .attributes['href']),

        previousChapterUrl: safeUrl(url, () =>
        document
            .querySelectorAll('.toplink > a')[0]
            .attributes['href']),
        nextChapterUrl: safeUrl(url, () =>
        document
            .querySelectorAll('.toplink > a')[2]
            .attributes['href']),
        paragraphs: safeList(() =>
            document
            .getElementById('content')
            .nodes
            .where((node) => node.nodeType == Node.TEXT_NODE)
            .map((node) => node.text.trim())
            .where((text) => text.isNotEmpty)
                .toList(growable: false))
    );
  }
}
