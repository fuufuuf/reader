import 'package:built_value/built_value.dart';

part 'ChapterRef.g.dart';

abstract class ChapterRef implements Built<ChapterRef, ChapterRefBuilder> {
  ChapterRef._();

  factory ChapterRef({Uri url, String title}) => _$ChapterRef((b) => b
    ..url = url
    ..title = title);

  Uri get url;

  String get title;
}
