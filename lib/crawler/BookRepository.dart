import 'package:timnew_reader/models/CurrentBook.dart';

import 'PiaotianAdapter.dart';
import 'ReaderHttpClient.dart';
import 'SiteAdapter.dart';

class BookCrawler {
  static ReaderHttpClient client = ReaderHttpClient();

  static Map<String, SiteAdapter> adapters = {
    'www.ptwxz.com': PiaotianAdapter(client)
  };

  static Future<CurrentBook> fetchChapterContent(Uri url,
      CurrentBook currentBook) async {
    final adapter = _findAdapter(url);

    return await adapter.fetchChapterContent(url, currentBook);
  }

  static Future<CurrentBook> fetchBookInfo(Uri url,
      CurrentBook currentBook) async {
    final adapter = _findAdapter(url);

    return await adapter.fetchBookInfo(url, currentBook);
  }

  static Future<CurrentBook> fetchChapterList(Uri url,
      CurrentBook currentBook) async {
    final adapter = _findAdapter(url);

    return await adapter.fetchChapterList(url, currentBook);
  }

  static Future<CurrentBook> fetchFromUrl(Uri url,
      CurrentBook currentBook) async {
    final adapter = _findAdapter(url);
    return await adapter.fetchFromUrl(url, currentBook);
  }

  static SiteAdapter _findAdapter(Uri url) {
    if (!url.hasScheme || !url.scheme.startsWith("http") || !url.isAbsolute) {
      throw Exception("Invalid Url");
    }

    final result = adapters[url.host];

    if (result == null) {
      throw Exception("Unknown Site found");
    }

    return result;
  }
}
