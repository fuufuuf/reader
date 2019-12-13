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

  BookIndex get bookIndex;

  @nullable
  BookInfo get bookInfo;

  @nullable
  BuiltList<ChapterRef> get chapterList;

  @nullable
  ChapterRef get chapter;

  @nullable
  ChapterContent get chapterContent;

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
