import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:built_collection/built_collection.dart';

part 'ChapterContent.freezed.dart';

@freezed
abstract class ChapterContent implements _$ChapterContent {
  ChapterContent._();

  factory ChapterContent({
    @required Uri url,
    @required String title,
    @required Uri chapterListUrl,
    @nullable Uri previousChapterUrl,
    Uri nextChapterUrl,
    @Default(false) bool isLocked,
    @required BuiltList<String> paragraphs,
  }) = _ChapterContent;

  bool get hasPrevious => previousChapterUrl != null;

  bool get hasNext => nextChapterUrl != null;
}
