import 'package:built_value/built_value.dart';
import 'package:reader/models/BookIndex.dart';

part 'NewBook.g.dart';

abstract class NewBook implements Built<NewBook, NewBookBuilder> {
  NewBook._();

  factory NewBook([updates(NewBookBuilder b)]) = _$NewBook;

  String get bookId;

  String get bookName;

  Uri get bookInfoUrl;

  Uri get chapterListUrl;

  @nullable
  Uri get currentChapterUrl;

  BookIndex toBookIndex() => BookIndex((b) => b
    ..bookId = bookId
    ..bookName = bookName
    ..bookInfoUrl = bookInfoUrl
    ..chapterListUrl = chapterListUrl);

  Future<BookIndex> save() async {
    var bookIndex = toBookIndex();
    await bookIndex.save();

    if (currentChapterUrl != null) {
      await bookIndex.setCurrentChapter(currentChapterUrl);
    }

    return bookIndex;
  }
}
