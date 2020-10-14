import 'package:meta/meta.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/BookInfo.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/models/NewBook.dart';
import 'package:timnew_reader/repositories/network/ReaderHttpClient.dart';

abstract class SiteAdapter {
  @protected
  final ReaderHttpClient client;

  Duration get defaultLoadTimeout => Duration(seconds: 3);

  bool canParse(Uri url);

  SiteAdapter(this.client);

  Future<BookInfo> fetchBookInfo(BookIndex bookIndex);

  Future<ChapterList> fetchChapterList(BookIndex bookIndex);

  Future<ChapterContent> fetchChapterContent(BookIndex bookIndex, Uri url);

  Future<NewBook> parseNewBook(Uri url);
}
