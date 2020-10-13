import 'package:built_value/built_value.dart';
import 'package:flutter/foundation.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/repositories/network/BookRepository.dart';

part 'BookInfo.g.dart';

abstract class BookInfo implements Built<BookInfo, BookInfoBuilder> {
  BookInfo._();

  factory BookInfo({
    @required Uri url,
    @required Uri chapterListUrl,
    @required String bookId,
    @required String title,
    String author,
    String genre,
    String completeness,
    String lastUpdated,
    String length,
  }) =>
      _$BookInfo((b) => b
        ..url = url
        ..chapterListUrl = chapterListUrl
        ..bookId = bookId
        ..title = title
        ..author = author
        ..genre = genre
        ..completeness = completeness
        ..lastUpdated = lastUpdated
        ..length = length);

  Uri get url;

  Future<BookInfo> reload() => BookRepository.fetchBookInfo(url);

  Uri get chapterListUrl;

  Future<ChapterList> fetchChapterList() => BookRepository.fetchChapterList(chapterListUrl);

  String get bookId;

  String get title;

  @nullable
  String get author;

  @nullable
  String get genre;

  @nullable
  String get completeness;

  @nullable
  String get lastUpdated;

  @nullable
  String get length;

  bool get hasAuthor => author != null;

  bool get hasGenre => genre != null;

  bool get hasCompleteness => completeness != null;

  bool get hasLastUpdated => lastUpdated != null;

  bool get hasLength => length != null;
}
