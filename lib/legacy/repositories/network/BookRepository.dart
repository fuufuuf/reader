import '../../models/BookInfo.dart';
import '../../models/ChapterContent.dart';
import '../../models/ChapterList.dart';
import '../../models/NewBook.dart';
import './PiaotianAdapter.dart';
import './ReaderHttpClient.dart';
import './SiteAdapter.dart';

class BookRepository {
  static ReaderHttpClient client = ReaderHttpClient();

  static Map<String, SiteAdapter> adapters = {
    'www.ptwxz.com': PiaotianAdapter(client)
  };

  static Future<NewBook> createBook(Uri url) =>
      _findAdapter(url).createBook(url);

  static Future<NewBook> createBookByUrlString(String url) =>
      _findAdapter(Uri.parse(url)).createBook(Uri.parse(url));

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
