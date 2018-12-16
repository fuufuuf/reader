import 'package:reader/models/BookEntry.dart';
import 'package:reader/models/BookInfo.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/models/ChapterList.dart';
import 'package:reader/repositories/network/PiaotianAdapter.dart';
import 'package:reader/repositories/network/ReaderHttpClient.dart';
import 'package:reader/repositories/network/SiteAdapter.dart';

class BookRepository {
  static ReaderHttpClient client = ReaderHttpClient();

  static Map<String, SiteAdapter> adapters = {
    'www.piaotian.com': PiaotianAdapter(client)
  };

  static Future<BookEntry> fetchBookEntry(Uri url) =>
      _findAdapter(url).fetchBookEntry(url);

  static Future<BookEntry> fetchBookEntryByUrlString(String url) async {
    Uri uri = Uri.parse(url);
    return _findAdapter(uri).fetchBookEntry(uri);
  }

  static Future<ChapterContent> fetchChapterContent(Uri url, [String title]) =>
      _findAdapter(url).fetchChapterContent(url);

  static Future<BookInfo> fetchBookInfo(Uri url) =>
      _findAdapter(url).fetchBookInfo(url);

  static Future<ChapterList> fetchChapterList(Uri url) =>
      _findAdapter(url).fetchChapterList(url);

  static Future<Object> fetchFromUrl(Uri url) =>
      _findAdapter(url).fetchFromUrl(url);

  static Future<Type> fetchResourceType(Uri url) =>
      _findAdapter(url).fetchResourceType(url);

  static SiteAdapter _findAdapter(Uri url) => adapters[url.host];
}
