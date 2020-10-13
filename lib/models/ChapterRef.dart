import 'package:built_value/built_value.dart';
import 'package:flutter/foundation.dart';

part 'ChapterRef.g.dart';

abstract class ChapterRef implements Built<ChapterRef, ChapterRefBuilder> {
  ChapterRef._();

  factory ChapterRef({
    @required String title,
    @required Uri url,
  }) =>
      _$ChapterRef((b) => b
        ..title = title
        ..url = url);

  Uri get url;

  String get title;
}
