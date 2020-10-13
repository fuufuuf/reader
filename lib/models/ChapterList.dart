import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/foundation.dart';
import 'package:timnew_reader/models/ChapterRef.dart';

part 'ChapterList.g.dart';

abstract class ChapterList implements Built<ChapterList, ChapterListBuilder> {
  ChapterList._();

  factory ChapterList({
    @required Uri url,
    @required String title,
    @required Uri bookInfoUrl,
    @required BuiltList<ChapterRef> chapters,
  }) =>
      _$ChapterList((b) => b
        ..url = url
        ..title = title
        ..bookInfoUrl = bookInfoUrl
        ..chapters.replace(chapters));

  Uri get url;

  String get title;

  Uri get bookInfoUrl;

  BuiltList<ChapterRef> get chapters;
}
