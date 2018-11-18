import 'package:reader/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:html/dom.dart';
import 'package:gbk2utf8/gbk2utf8.dart';

class Downloader {
  Future<Book> fetchIndex(Book book) async {
    final page = await _fetchHtml(book.url, book.enforceGbk);

    await parseBook(book, page);

    return book;
  }

  parseBook(Book book, String page) async {
    final document = htmlParser.parse(page, encoding: 'utf8');

    book.title =
        document.querySelector('.title h1').text.trim().replaceAll("最新章节", "");
    book.author = document
        .querySelector('.mainbody .list')
        .firstChild
        .text
        .trim()
        .replaceAll('作者：', '');

    final bookUrl = Uri.parse(book.url);

    book.chapters = document
        .querySelectorAll('.mainbody .centent ul li a')
        .map((element) => Chapter(
            bookUrl.resolve(element.attributes['href']).toString(),
            element.text))
        .toList(growable: false);
  }

  Future<Chapter> fetchContent(Book book, Chapter chapter) async {
    final page = await _fetchHtml(chapter.url, book.enforceGbk);

    chapter.content = await parseContent(chapter, page);

    return chapter;
  }

  Future<List<String>> parseContent(Chapter chapter, String page) async {
    final newPage = page.replaceFirst(
        '<script language="javascript">GetFont();</script>',
        '<div id="content">');

    final document = htmlParser.parse(newPage, encoding: 'utf8');

    return document
        .getElementById('content')
        .nodes
        .where((node) => node.nodeType == Node.TEXT_NODE)
        .map((node) => node.text.trim())
        .where((text) => text.isNotEmpty)
        .toList(growable: false);
  }

  Future<String> _fetchHtml(String url, bool enforceGbk) async {
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
}
