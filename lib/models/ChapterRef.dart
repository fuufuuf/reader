import 'package:built_value/built_value.dart';
import 'package:flutter/foundation.dart';

part 'ChapterRef.g.dart';

abstract class ChapterRef implements Built<ChapterRef, ChapterRefBuilder> {
  ChapterRef._();

  factory ChapterRef({
    @required String title,
    @required Uri url,
    bool isLocked: false,
  }) =>
      _$ChapterRef((b) => b
        ..title = title
        ..url = url
        ..isLocked = isLocked);

  Uri get url;

  String get title;

  bool get isLocked;
}
