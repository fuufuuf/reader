import 'package:meta/meta.dart';
import 'package:reader/models/Book.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/models/TableOfContents.dart';
import 'package:reader/repositories/ReaderHttpClient.dart';

abstract class SiteAdapter {
  @protected final ReaderHttpClient client;

  SiteAdapter(this.client);

  Future<Book> openBook(Uri url);

  Future<ChapterContent> openChapter(Uri url);

  Future<TableOfContents> openMenu(Uri url);

  Future<Type> checkType(Uri url);

  Future<Object> open(Uri url) async {
    switch (await checkType(url)) {
      case Book:
        return openBook(url);
      case TableOfContents:
        return openMenu(url);
      case ChapterContent:
        return openChapter(url);
      default:
        throw "Unknown url type";
    }
  }
}
