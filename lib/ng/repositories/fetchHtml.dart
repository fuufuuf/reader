import 'package:gbk2utf8/gbk2utf8.dart';
import 'package:http/http.dart' as http;

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
