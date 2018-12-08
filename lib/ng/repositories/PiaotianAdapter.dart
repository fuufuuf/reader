import 'package:html/dom.dart';
import 'package:reader/ng/models/Book.dart';
import 'package:reader/ng/models/Chapter.dart';
import 'package:reader/ng/models/Menu.dart';
import 'package:reader/ng/repositories/HttpClient.dart';
import 'package:reader/ng/repositories/SiteAdapter.dart';
import 'package:reader/ng/repositories/safeExtractors.dart';

class PiaotianAdapter extends SiteAdapter {
  PiaotianAdapter(HttpClient client) :super(client);

  static final bookUrlPattern = RegExp(
      r"https://www.piaotian.com/bookinfo/(\d+)/(\d+).html",
      caseSensitive: false);

  static final menuUrlPattern = RegExp(
      r"https://www.piaotian.com/html/(\d+)/(\d+)/(index.html)?",
      caseSensitive: false);

  static final chapterUrlPattern = RegExp(
      r"https://www.piaotian.com/html/(\d+)/(\d+)/(\d+).html",
      caseSensitive: false);

  @override
  Future<Type> checkType(Uri url) async {
    var urlString = url.toString();

    if (chapterUrlPattern.hasMatch(urlString)) {
      return Chapter;
    }

    if (menuUrlPattern.hasMatch(urlString)) {
      return Menu;
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
          .querySelector(
              '#content > table > tbody > tr:nth-child(1) > td > table > tbody > tr:nth-child(2) > td:nth-child(2)')
              ?.text
      ),
      menuUrl: safeUrl(
          url,
              () =>
          document
              .querySelector('a[tiptitle^="点击阅读"]')
              ?.attributes['href']),
      latestChapterUrl: safeUrl(
          url,
              () =>
          document
          .querySelector(
              '#content > table > tbody > tr:nth-child(4) > td > table > tbody > tr > td:nth-child(2) > div > a')
          ?.attributes['href']),
    );
  }

  @override
  Future<Menu> openMenu(Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return Menu(
        url: url,
        title: safeText(() =>
            document
            .querySelector('.title h1')
                ?.text
                ?.trim()
                ?.replaceAll("最新章节", "")),
        chapters: safeList(() =>
            document
            .querySelectorAll('.mainbody .centent ul li a')
            .map((element) => ChapterIndex(
                url: url.resolve(element.attributes['href']),
                title: element.text))
                .toList(growable: false)
        )
    );
  }

  @override
  Future<Chapter> openChapter(Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return Chapter(
        url: url,
        title: safeText(() =>
        document
            .querySelector('h1')
            .text),
        bookUrl: safeUrl(url, () =>
        document
            .querySelector('#content > div.toplink > a:nth-child(4)')
            .attributes['href']),
        menuUrl: safeUrl(url, () =>
        document
            .querySelector('#content > div.toplink > a:nth-child(2)')
            .attributes['href']),

        previousChapterUrl: safeUrl(url, () =>
        document
            .querySelector('#content > div.toplink > a:nth-child(1)')
            .attributes['href']),
        nextChapterUrl: safeUrl(url, () =>
        document
            .querySelector('#content > div.toplink > a:nth-child(3)')
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
