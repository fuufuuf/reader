import 'package:meta/meta.dart';
import 'package:reader/models/Book.dart';
import 'package:reader/models/Chapter.dart';
import 'package:reader/models/Menu.dart';
import 'package:reader/repositories/ReaderHttpClient.dart';

abstract class SiteAdapter {
  @protected final ReaderHttpClient client;

  SiteAdapter(this.client);

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
