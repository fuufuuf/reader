import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timnew_reader/models/BookIndex.dart';

part 'ChapterRef.freezed.dart';

@freezed
abstract class ChapterRef with HasBookIndex implements _$ChapterRef {
  ChapterRef._();

  factory ChapterRef({
    @required BookIndex bookIndex,
    @required String title,
    @required Uri url,
    @Default(false) bool isLocked,
  }) = _ChapterRef;
}
