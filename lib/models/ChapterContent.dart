import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:built_collection/built_collection.dart';
import 'package:timnew_reader/models/BookIndex.dart';

part 'ChapterContent.freezed.dart';

@freezed
abstract class ChapterContent with HasBookIndex implements _$ChapterContent {
  ChapterContent._();

  factory ChapterContent({
    @required BookIndex bookIndex,
    @required Uri url,
    @required String title,
    @nullable Uri previousChapterUrl,
    @nullable Uri nextChapterUrl,
    @Default(false) bool isLocked,
    @required BuiltList<String> paragraphs,
  }) = _ChapterContent;

  bool get hasPrevious => previousChapterUrl != null;

  bool get hasNext => nextChapterUrl != null;
}
