import 'package:freezed_annotation/freezed_annotation.dart';

part 'ChapterRef.freezed.dart';

@freezed
abstract class ChapterRef with _$ChapterRef {
  factory ChapterRef({
    @required String title,
    @required Uri url,
    @Default(false) bool isLocked,
  }) = _ChapterRef;
}
