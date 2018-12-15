import 'package:built_value/built_value.dart';

part 'ChapterRef.g.dart';

abstract class ChapterRef implements Built<ChapterRef, ChapterRefBuilder> {
  ChapterRef._();

  factory ChapterRef([updates(ChapterRefBuilder b)]) = _$ChapterRef;

  Uri get url;

  String get title;
}
