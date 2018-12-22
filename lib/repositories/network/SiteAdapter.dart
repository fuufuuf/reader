import 'package:meta/meta.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/models/BookInfo.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/models/ChapterList.dart';
import 'package:reader/models/NewBook.dart';
import 'package:reader/repositories/network/ReaderHttpClient.dart';

abstract class SiteAdapter {
  @protected final ReaderHttpClient client;

  SiteAdapter(this.client);

  Future<BookInfo> fetchBookInfo(Uri url);

  Future<ChapterContent> fetchChapterContent(Uri url);

  Future<ChapterList> fetchChapterList(Uri url);

  Future<Type> fetchResourceType(Uri url);

  Future<NewBook> fetchBookEntry(Uri url) ;

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
