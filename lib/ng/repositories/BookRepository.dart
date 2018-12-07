import 'package:meta/meta.dart';
import 'package:reader/ng/models/Page.dart';
import 'package:reader/ng/repositories/SiteAdapter.dart';

class BookRepository {
  static Map<String, SiteAdapter> adapters = {
  };

  static Future<Chapter> openChapter(@required Uri url, [String title]) =>
      _findAdapter(url).openChapter(url);

  static Future<Book> openBook(@required Uri url) =>
      _findAdapter(url).openBook(url);

  static Future<Menu> openMenu(@required Uri url) =>
      _findAdapter(url).openMenu(url);

  static Future<Object> openUrl(@required Uri url) =>
      _findAdapter(url).open(url);

  static _findAdapter(@required Uri url) => adapters[url.host];
}
