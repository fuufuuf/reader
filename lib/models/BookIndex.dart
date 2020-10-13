import 'package:freezed_annotation/freezed_annotation.dart';

part 'BookIndex.freezed.dart';

part 'BookIndex.g.dart';

@freezed
abstract class BookIndex with _$BookIndex {
  factory BookIndex({
    @required String bookId,
    @required String bookName,
    @required Uri bookInfoUrl,
    @required Uri chapterListUrl,
  }) = _BookIndex;

  factory BookIndex.fromJson(Map<String, dynamic> json) => _$BookIndexFromJson(json);
}
