import 'package:reader/ng/models/Book.dart';
import 'package:reader/ng/models/Chapter.dart';
import 'package:reader/ng/models/Menu.dart';
import 'package:reader/ng/repositories/PiaotianAdapter.dart';
import 'package:reader/ng/repositories/SiteAdapter.dart';

class BookRepository {
  static Map<String, SiteAdapter> adapters = {
    'www.piaotian.com': PiaotianAdapter()
  };

  static Future<Chapter> openChapter(Uri url, [String title]) =>
      _findAdapter(url).openChapter(url);

  static Future<Book> openBook(Uri url) =>
      _findAdapter(url).openBook(url);

  static Future<Menu> openMenu(Uri url) =>
      _findAdapter(url).openMenu(url);

  static Future<Object> openUrl(Uri url) =>
      _findAdapter(url).open(url);

  static _findAdapter(Uri url) => adapters[url.host];
}
