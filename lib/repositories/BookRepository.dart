import 'package:reader/models/Book.dart';
import 'package:reader/models/Chapter.dart';
import 'package:reader/models/Menu.dart';
import 'package:reader/repositories/ReaderHttpClient.dart';
import 'package:reader/repositories/PiaotianAdapter.dart';
import 'package:reader/repositories/SiteAdapter.dart';

class BookRepository {
  static ReaderHttpClient client = ReaderHttpClient();

  static Map<String, SiteAdapter> adapters = {
    'www.piaotian.com': PiaotianAdapter(client)
  };

  static Future<Chapter> openChapter(Uri url, [String title]) =>
      _findAdapter(url).openChapter(url);

  static Future<Book> openBook(Uri url) =>
      _findAdapter(url).openBook(url);

  static Future<Menu> openMenu(Uri url) =>
      _findAdapter(url).openMenu(url);

  static Future<Object> openUrl(Uri url) =>
      _findAdapter(url).open(url);

  static Future<Type> checkType(Uri url) =>
      _findAdapter(url).checkType(url);

  static _findAdapter(Uri url) => adapters[url.host];
}
