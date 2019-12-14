import 'package:meta/meta.dart';
import '../../models/BookInfo.dart';
import '../../models/ChapterContent.dart';
import '../../models/ChapterList.dart';
import '../../models/NewBook.dart';
import './ReaderHttpClient.dart';

abstract class SiteAdapter {
  @protected final ReaderHttpClient client;

  SiteAdapter(this.client);

  Future<BookInfo> fetchBookInfo(Uri url);

  Future<ChapterContent> fetchChapterContent(Uri url);

  Future<ChapterList> fetchChapterList(Uri url);

  Future<Type> fetchResourceType(Uri url);

  Future<NewBook> createBook(Uri url) ;

  Future<Object> fetchFromUrl(Uri url) async {
    switch (await fetchResourceType(url)) {
      case BookInfo:
        return fetchBookInfo(url);
      case ChapterList:
        return fetchChapterList(url);
      case ChapterContent:
        return fetchChapterContent(url);
      default:
        throw "Unknown url type";
    }
  }
}
