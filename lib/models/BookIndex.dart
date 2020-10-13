import 'package:freezed_annotation/freezed_annotation.dart';

part 'BookIndex.freezed.dart';

part 'BookIndex.g.dart';

@freezed
abstract class BookIndex with _$BookIndex {
  factory BookIndex({
    @required String adapter,
    @required String bookId,
    @required String bookName,
    @required Uri bookInfoUrl,
    @required Uri chapterListUrl,
  }) = _BookIndex;

  factory BookIndex.fromJson(Map<String, dynamic> json) => _$BookIndexFromJson(json);
}

mixin HasBookIndex {
  BookIndex get bookIndex;

  String get adapter => bookIndex.adapter;

  String get bookId => bookIndex.bookId;

  String get bookName => bookIndex.bookName;

  Uri get bookInfoUrl => bookIndex.bookInfoUrl;

  Uri get chapterListUrl => bookIndex.chapterListUrl;
}
