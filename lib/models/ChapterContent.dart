import 'package:meta/meta.dart';
import 'package:built_value/built_value.dart';

part 'ChapterContent.g.dart';

abstract class ChapterContent
    implements Built<ChapterContent, ChapterContentBuilder> {
  ChapterContent._();

  factory ChapterContent([updates(ChapterContentBuilder b)]) = _$ChapterContent;

  Uri get url;

  String get title;

  List<String> get paragraphs;

  Uri get menuUrl;

  @nullable
  Uri get nextChapterUrl;

  @nullable
  Uri get previousChapterUrl;

  bool get hasPrevious => previousChapterUrl != null;

  bool get hasNext => nextChapterUrl != null;
}
