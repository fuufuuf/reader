import 'package:reader/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart';
import 'package:gbk2utf8/gbk2utf8.dart';

typedef Downloader DownloaderFactory();

abstract class Downloader {
  Future<String> fetchHtml(Uri url, bool enforceGbk) async {
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw "Http Error ${response.statusCode}";
    }

    if (enforceGbk) {
      return decodeGbk(response.bodyBytes);
    } else {
      return response.body;
    }
  }

  bool get enforceGbk;

  Future<Book> fetchIndex(Book book) async {
    final page = await fetchHtml(book.url, enforceGbk);

    parseBook(book, page);

    return book;
  }

  Future<Chapter> fetchChapter(Book book, Chapter chapter) async {
    final page = await fetchHtml(chapter.url, enforceGbk);

    parseChapter(chapter, page);

    return chapter;
  }

  parseBook(Book book, String page);

  parseChapter(Chapter chapter, String page);

  static Map<String, DownloaderFactory> factories = {
    'www.piaotian.com': () => PiaotianDownloader()
  };

  static Downloader findDownloader(WebContent content) =>
      factories[content.url.host]();
}

class PiaotianDownloader extends Downloader {
  bool get enforceGbk => true;

  parseBook(Book book, String page) {
    final document = htmlParser.parse(page, encoding: 'utf8');

    book.title =
        document.querySelector('.title h1').text.trim().replaceAll("最新章节", "");
    book.author = document
        .querySelector('.mainbody .list')
        .firstChild
        .text
        .trim()
        .replaceAll('作者：', '');

    book.chapters = document
        .querySelectorAll('.mainbody .centent ul li a')
        .map((element) =>
            Chapter(book.url.resolve(element.attributes['href']), element.text))
        .toList(growable: false);
  }

  parseChapter(Chapter chapter, String page) {
    final newPage = page.replaceFirst(
        '<script language="javascript">GetFont();</script>',
        '<div id="content">');

    final document = htmlParser.parse(newPage, encoding: 'utf8');

    chapter.content = document
        .getElementById('content')
        .nodes
        .where((node) => node.nodeType == Node.TEXT_NODE)
        .map((node) => node.text.trim())
        .where((text) => text.isNotEmpty)
        .toList(growable: false);
  }
}
