import 'package:meta/meta.dart';
import 'package:timnew_reader/app/UserException.dart';
import 'package:timnew_reader/models/BookInfo.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/models/NewBook.dart';
import 'package:timnew_reader/repositories/network/ReaderHttpClient.dart';

abstract class SiteAdapter {
  @protected
  final ReaderHttpClient client;

  SiteAdapter(this.client);

  Future<BookInfo> fetchBookInfo(Uri url);

  Future<ChapterContent> fetchChapterContent(Uri url);

  Future<ChapterList> fetchChapterList(Uri url);

  Future<Type> fetchResourceType(Uri url);

  Future<NewBook> createBook(Uri url);

  Future<Object> fetchFromUrl(Uri url) async {
    switch (await fetchResourceType(url)) {
      case BookInfo:
        return fetchBookInfo(url);
      case ChapterList:
        return fetchChapterList(url);
      case ChapterContent:
        return fetchChapterContent(url);
      default:
        throw UserException("無法解析的 Url: $url");
    }
  }
}
