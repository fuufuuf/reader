import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'ChapterContent.g.dart';

abstract class ChapterContent
    implements Built<ChapterContent, ChapterContentBuilder> {
  ChapterContent._();

  factory ChapterContent([updates(ChapterContentBuilder b)]) = _$ChapterContent;

  Uri get url;

  String get title;

  BuiltList<String> get paragraphs;

  Uri get chapterListUrl;

  @nullable
  Uri get nextChapterUrl;

  @nullable
  Uri get previousChapterUrl;

  bool get hasPrevious => previousChapterUrl != null;

  bool get hasNext => nextChapterUrl != null;
}
