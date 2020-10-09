import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:timnew_reader/models/ChapterRef.dart';

part 'ChapterList.g.dart';

abstract class ChapterList implements Built<ChapterList, ChapterListBuilder> {
  ChapterList._();

  factory ChapterList([updates(ChapterListBuilder b)]) = _$ChapterList;

  Uri get url;

  String get title;

  Uri get bookInfoUrl;

  BuiltList<ChapterRef> get chapters;
}
