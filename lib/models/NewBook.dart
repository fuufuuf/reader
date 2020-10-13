import 'package:built_value/built_value.dart';
import 'package:flutter/foundation.dart';
import 'package:timnew_reader/models/BookIndex.dart';

part 'NewBook.g.dart';

abstract class NewBook implements Built<NewBook, NewBookBuilder> {
  NewBook._();

  factory NewBook({
    @required String bookId,
    @required String bookName,
    @required Uri bookInfoUrl,
    @required Uri chapterListUrl,
  }) =>
      _$NewBook((b) {
        b.bookIndex
          ..bookId = bookId
          ..bookName = bookName
          ..bookInfoUrl = bookInfoUrl
          ..chapterListUrl = chapterListUrl;

        b.isDuplicated = false;
      });

  BookIndex get bookIndex;

  bool get isDuplicated;

  @nullable
  Uri get currentChapterUrl;

  String get bookId => bookIndex.bookId;

  String get bookName => bookIndex.bookName;

  Uri get bookInfoUrl => bookIndex.bookInfoUrl;

  Uri get chapterListUrl => bookIndex.chapterListUrl;

  bool get hasCurrentChapterUrl => currentChapterUrl != null;

  NewBook markAsDuplicated() => rebuild((builder) => builder.isDuplicated = true);
}
