import 'package:meta/meta.dart';
import 'package:timnew_reader/models/CurrentBook.dart';
import 'package:timnew_reader/models/book_models.dart';

import 'ReaderHttpClient.dart';

abstract class SiteAdapter {
  @protected final ReaderHttpClient client;

  SiteAdapter(this.client);

  Future<CurrentBook> fetchBookInfo(Uri url, CurrentBook currentBook);

  Future<CurrentBook> fetchChapterContent(Uri url, CurrentBook currentBook);

  Future<CurrentBook> fetchChapterList(Uri url, CurrentBook currentBook);

  Future<Type> fetchResourceType(Uri url);

  Future<CurrentBook> fetchFromUrl(Uri url, CurrentBook currentBook) async {
    switch (await fetchResourceType(url)) {
      case BookInfo:
        return fetchBookInfo(url, currentBook);
      case ChapterRef:
        return fetchChapterList(url, currentBook);
      case ChapterContent:
        return fetchChapterContent(url, currentBook);
      default:
        throw "Unknown url type";
    }
  }
}
