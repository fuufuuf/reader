import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:built_collection/built_collection.dart';

import 'ChapterRef.dart';

part 'ChapterList.freezed.dart';

@freezed
abstract class ChapterList with _$ChapterList {
  factory ChapterList({
    @required Uri url,
    @required String title,
    @required Uri bookInfoUrl,
    @required BuiltList<ChapterRef> chapters,
  }) = _ChapterList;
}
