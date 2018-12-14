import 'package:reader/models/Book.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/models/TableOfContents.dart';
import 'package:reader/repositories/network/ReaderHttpClient.dart';
import 'package:reader/repositories/network/PiaotianAdapter.dart';
import 'package:reader/repositories/network/SiteAdapter.dart';

class BookRepository {
  static ReaderHttpClient client = ReaderHttpClient();

  static Map<String, SiteAdapter> adapters = {
    'www.piaotian.com': PiaotianAdapter(client)
  };

  static Future<ChapterContent> openChapter(Uri url, [String title]) =>
      _findAdapter(url).openChapter(url);

  static Future<Book> openBook(Uri url) =>
      _findAdapter(url).openBook(url);

  static Future<TableOfContents> openMenu(Uri url) =>
      _findAdapter(url).openMenu(url);

  static Future<Object> openUrl(Uri url) =>
      _findAdapter(url).open(url);

  static Future<Type> checkType(Uri url) =>
      _findAdapter(url).checkType(url);

  static _findAdapter(Uri url) => adapters[url.host];
}
