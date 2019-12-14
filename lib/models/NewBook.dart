import 'package:built_value/built_value.dart';

import 'book_models.dart';

part 'NewBook.g.dart';

abstract class NewBook implements Built<NewBook, NewBookBuilder> {
  NewBook._();

  BookIndex get book;

  @nullable
  ChapterRef get currentChapter;

  factory NewBook([updates(NewBookBuilder b)]) = _$NewBook;
}
