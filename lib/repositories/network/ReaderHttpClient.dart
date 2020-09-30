import 'package:gbk2utf8/gbk2utf8.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:http/http.dart' as http;

class ReaderHttpClient {
  Future<Document> fetchDom(Uri url, {bool enforceGbk: false, String patchHtml(String html)}) =>
      fetchHtml(url, enforceGbk: enforceGbk)
          .then((html) => (patchHtml == null) ? html : patchHtml(html))
          .then((html) => htmlParser.parse(html, encoding: 'utf8'));

  Future<String> fetchHtml(Uri url, {bool enforceGbk: false}) async {
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
