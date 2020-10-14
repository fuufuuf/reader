import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:timnew_reader/models/BookIndex.dart';

part 'NewBook.freezed.dart';

@freezed
abstract class NewBook with HasBookIndex implements _$NewBook {
  NewBook._();

  factory NewBook({
    @required String adapter,
    @required String bookId,
    @required String bookName,
    @required Uri bookInfoUrl,
    @required Uri chapterListUrl,
    Uri currentChapterUrl,
    bool isDuplicated: false,
  }) =>
      NewBook.fromBookIndex(
        bookIndex: BookIndex(
          adapter: adapter,
          bookId: bookId,
          bookName: bookName,
          bookInfoUrl: bookInfoUrl,
          chapterListUrl: chapterListUrl,
        ),
        currentChapterUrl: currentChapterUrl,
        isDuplicated: isDuplicated,
      );

  factory NewBook.fromBookIndex({
    @required BookIndex bookIndex,
    @nullable Uri currentChapterUrl,
    @Default(false) bool isDuplicated,
  }) = _NewBook;

  bool get hasCurrentChapterUrl => currentChapterUrl != null;

  NewBook markAsDuplicated() => copyWith(isDuplicated: true);
}
