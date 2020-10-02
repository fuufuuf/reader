import 'package:built_value/built_value.dart';
import 'package:timnew_reader/models/BookIndex.dart';

part 'NewBook.g.dart';

abstract class NewBook implements Built<NewBook, NewBookBuilder> {
  NewBook._();

  factory NewBook({String bookId, String bookName, Uri bookInfoUrl, Uri chapterListUrl}) => _$NewBook((b) {
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

  BookIndex toBookIndex() => bookIndex;

  Future<BookIndex> save() async {
    var bookIndex = toBookIndex();
    await bookIndex.save();

    if (currentChapterUrl != null) {
      await bookIndex.setCurrentChapter(currentChapterUrl);
    }

    return bookIndex;
  }

  NewBook markAsDuplicated() => rebuild((builder) => builder.isDuplicated = true);
}
