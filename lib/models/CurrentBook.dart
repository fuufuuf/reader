import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:timnew_reader/models/book_models.dart';

part 'CurrentBook.g.dart';

enum CurrentBookAspect {
  BookIndex,
  BookInfo,
  ChapterList,
  Chapter,
  ChapterContent
}

abstract class CurrentBook implements Built<CurrentBook, CurrentBookBuilder> {
  CurrentBook._();

  factory CurrentBook([updates(CurrentBookBuilder b)]) = _$CurrentBook;

  @nullable
  BookIndex get bookIndex;

  bool get hasBookIndex=> bookIndex != null;

  @nullable
  BookInfo get bookInfo;

  bool get hasBookInfo => bookInfo != null;

  @nullable
  BuiltList<ChapterRef> get chapterList;

  bool get hasChapterList => chapterList != null;

  @nullable
  ChapterRef get chapter;

  bool get hasChapter => chapter != null;

  @nullable
  ChapterContent get chapterContent;

  bool get hasChapterContent => chapterContent != null;

  dynamic selectBy(CurrentBookAspect aspect) {
    switch (aspect) {
      case CurrentBookAspect.BookIndex:
        return bookIndex;
      case CurrentBookAspect.BookInfo:
        return bookInfo;
      case CurrentBookAspect.ChapterList:
        return chapterList;
      case CurrentBookAspect.Chapter:
        return chapter;
      case CurrentBookAspect.ChapterContent:
        return ChapterContent;
    }
  }
}
