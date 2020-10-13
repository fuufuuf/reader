import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:timnew_reader/models/BookIndex.dart';

part 'NewBook.freezed.dart';

@freezed
abstract class NewBook implements _$NewBook {
  NewBook._();

  factory NewBook({
    @required String bookId,
    @required String bookName,
    @required Uri bookInfoUrl,
    @required Uri chapterListUrl,
  }) =>
      NewBook.fromBookIndex(
        bookIndex: BookIndex(
          bookId: bookId,
          bookName: bookName,
          bookInfoUrl: bookInfoUrl,
          chapterListUrl: chapterListUrl,
        ),
      );

  factory NewBook.fromBookIndex({
    @required BookIndex bookIndex,
    @nullable Uri currentChapterUrl,
    @Default(false) bool isDuplicated,
  }) = _NewBook;

  String get bookId => bookIndex.bookId;

  String get bookName => bookIndex.bookName;

  Uri get bookInfoUrl => bookIndex.bookInfoUrl;

  Uri get chapterListUrl => bookIndex.chapterListUrl;

  bool get hasCurrentChapterUrl => currentChapterUrl != null;

  NewBook markAsDuplicated() => copyWith(isDuplicated: true);
}
