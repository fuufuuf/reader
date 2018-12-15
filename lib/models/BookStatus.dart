import 'package:built_value/built_value.dart';

part 'BookStatus.g.dart';

abstract class BookStatus implements Built<BookStatus, BookStatusBuilder> {
  BookStatus._();

  factory BookStatus([updates(BookStatusBuilder b)]) = _$BookStatus;

  String get id;

  String get bookName;

  String get menuUrl;

  String get bookurl;

  @nullable
  String get currentUrl;
}
