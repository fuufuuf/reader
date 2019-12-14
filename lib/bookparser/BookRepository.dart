import 'package:timnew_reader/models/CurrentBook.dart';

import 'PiaotianAdapter.dart';
import 'ReaderHttpClient.dart';
import 'SiteAdapter.dart';

class BookRepository {
  static ReaderHttpClient client = ReaderHttpClient();

  static Map<String, SiteAdapter> adapters = {
    'www.ptwxz.com': PiaotianAdapter(client)
  };

  static Future<CurrentBook> fetchChapterContent(Uri url,
      CurrentBook currentBook) =>
      _findAdapter(url).fetchChapterContent(url, currentBook);

  static Future<CurrentBook> fetchBookInfo(Uri url, CurrentBook currentBook) =>
      _findAdapter(url).fetchBookInfo(url, currentBook);

  static Future<CurrentBook> fetchChapterList(Uri url,
      CurrentBook currentBook) =>
      _findAdapter(url).fetchChapterList(url, currentBook);

  static Future<CurrentBook> fetchFromUrl(Uri url, CurrentBook currentBook) =>
      _findAdapter(url).fetchFromUrl(url, currentBook);

  static SiteAdapter _findAdapter(Uri url) => adapters[url.host];
}
