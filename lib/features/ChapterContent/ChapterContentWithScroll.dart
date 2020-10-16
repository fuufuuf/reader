import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timnew_reader/features/ChapterContent/ScrollTarget.dart';
import 'package:timnew_reader/models/ChapterContent.dart';

part 'ChapterContentWithScroll.freezed.dart';

@freezed
abstract class ChapterContentWithScroll implements _$ChapterContentWithScroll {
  ChapterContentWithScroll._();

  factory ChapterContentWithScroll({
    @required ChapterContent chapter,
    @required ScrollTarget scrollTarget,
  }) = _ChapterContentWithScroll;

  Uri get previousChapterUrl => chapter.previousChapterUrl;

  bool get hasPrevious => previousChapterUrl != null;

  Uri get nextChapterUrl => chapter.nextChapterUrl;

  bool get hasNext => nextChapterUrl != null;
}
