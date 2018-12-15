import 'package:built_value/built_value.dart';

part 'BookEntry.g.dart';

abstract class BookEntry implements Built<BookEntry, BookEntryBuilder> {
  BookEntry._();

  factory BookEntry([updates(BookEntryBuilder b)]) = _$BookEntry;

  String get id;

  String get bookName;

  String get menuUrl;

  String get bookUrl;

  @nullable
  String get currentUrl;
}
