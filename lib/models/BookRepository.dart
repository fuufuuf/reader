import 'package:reader/models/Page.dart';

class BookRepository {
  static Map<String, SiteAdapter> adapters = {};

  static Future<Chapter> openChapter(Uri url, [String title]) =>
      _findAdapter(url).openChapter(url);

  static Future<Book> openBook(Uri url) => _findAdapter(url).openBook(url);

  static Future<Menu> openMenu(Uri url) => _findAdapter(url).openMenu(url);

  static Future<Object> openUrl(Uri url) => _findAdapter(url).open(url);

  static _findAdapter(Uri url) => adapters[url.host];
}

abstract class SiteAdapter {
  Future<Book> openBook(Uri url);

  Future<Chapter> openChapter(Uri url);

  Future<Menu> openMenu(Uri url);

  Future<Type> checkType(Uri url);

  Future<Object> open(Uri url) async {
    switch (await checkType(url)) {
      case Book:
        return openBook(url);
      case Menu:
        return openMenu(url);
      case Chapter:
        return openChapter(url);
      default:
        throw "Unknown url type";
    }
  }
}
