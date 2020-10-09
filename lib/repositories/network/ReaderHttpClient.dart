import 'package:gbk2utf8/gbk2utf8.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:http/http.dart' as http;
import 'package:timnew_reader/app/UserException.dart';

class ReaderHttpClient {
  Future<Document> fetchDom(Uri url, {bool enforceGbk: false, String patchHtml(String html)}) =>
      fetchHtml(url, enforceGbk: enforceGbk)
          .then((html) => (patchHtml == null) ? html : patchHtml(html))
          .then((html) => htmlParser.parse(html, encoding: 'utf8'));

  Future<String> fetchHtml(Uri url, {bool enforceGbk: false}) async {
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw UserException("HTTP 錯誤 ${response.statusCode}");
    }

    if (enforceGbk) {
      return gbk.decode(response.bodyBytes);
    } else {
      return response.body;
    }
  }
}
