import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:built_collection/built_collection.dart';
import 'package:timnew_reader/models/BookIndex.dart';

import 'ChapterRef.dart';

part 'ChapterList.freezed.dart';

@freezed
abstract class ChapterList with HasBookIndex implements _$ChapterList {
  ChapterList._();

  factory ChapterList({
    @required BookIndex bookIndex,
    @required BuiltList<ChapterRef> chapters,
  }) = _ChapterList;
}
