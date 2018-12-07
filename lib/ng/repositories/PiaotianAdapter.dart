import 'package:html/dom.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:reader/ng/models/Book.dart';
import 'package:reader/ng/models/Chapter.dart';
import 'package:reader/ng/models/Menu.dart';
import 'package:reader/ng/repositories/SiteAdapter.dart';
import 'package:reader/ng/repositories/fetchHtml.dart';

class PiaotianAdapter extends SiteAdapter {
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

    return throw "Unknown Url: $url";
  }

  @override
  Future<Book> openBook(Uri url) async {
    var html = await fetchHtml(url, true);
    final document = htmlParser.parse(html, encoding: 'utf8');

    return Book(
      url: url,
      title: document.querySelector('h1').text.trim(),
      author: document
          .querySelector(
              '#content > table > tbody > tr:nth-child(1) > td > table > tbody > tr:nth-child(2) > td:nth-child(2)')
          ?.text
          ?.trim(),
      menuUrl: url.resolve(
          document.querySelector('a[tiptitle^="点击阅读"]').attributes['href']),
      latestChapterUrl: url.resolve(document
          .querySelector(
              '#content > table > tbody > tr:nth-child(4) > td > table > tbody > tr > td:nth-child(2) > div > a')
          ?.attributes['href']),
    );
  }

  @override
  Future<Menu> openMenu(Uri url) async {
    var html = await fetchHtml(url, true);
    final document = htmlParser.parse(html, encoding: 'utf8');

    return Menu(
        url: url,
        title: document
            .querySelector('.title h1')
            .text
            .trim()
            .replaceAll("最新章节", ""),
        chapters: document
            .querySelectorAll('.mainbody .centent ul li a')
            .map((element) => ChapterIndex(
                url: url.resolve(element.attributes['href']),
                title: element.text))
            .toList(growable: false));
  }

  @override
  Future<Chapter> openChapter(Uri url) async {
    var html = await fetchHtml(url, true);
    final document = htmlParser.parse(html, encoding: 'utf8');

    return Chapter(
        url: url,
        title: document.querySelector('h1').text.trim(),
        bookUrl: url.resolve(document
            .querySelector('#content > div.toplink > a:nth-child(4)')
            .attributes['href']),
        menuUrl: url.resolve(document
            .querySelector('#content > div.toplink > a:nth-child(2)')
            .attributes['href']),
        previousChapterUrl: url.resolve(document
            .querySelector('#content > div.toplink > a:nth-child(1)')
            .attributes['href']),
        nextChapterUrl: url.resolve(document
            .querySelector('#content > div.toplink > a:nth-child(3)')
            .attributes['href']),
        paragraphs: document
            .getElementById('content')
            .nodes
            .where((node) => node.nodeType == Node.TEXT_NODE)
            .map((node) => node.text.trim())
            .where((text) => text.isNotEmpty)
            .toList(growable: false));
  }
}
