import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/foundation.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/repositories/network/BookRepository.dart';

part 'ChapterContent.g.dart';

abstract class ChapterContent implements Built<ChapterContent, ChapterContentBuilder> {
  factory ChapterContent({
    @required Uri url,
    @required String title,
    @required Uri chapterListUrl,
    Uri previousChapterUrl,
    Uri nextChapterUrl,
    bool isLocked: false,
    BuiltList<String> paragraphs,
  }) =>
      _$ChapterContent((b) => b
        ..url = url
        ..title = title
        ..chapterListUrl = chapterListUrl
        ..previousChapterUrl = previousChapterUrl
        ..nextChapterUrl = nextChapterUrl
        ..isLocked = isLocked
        ..paragraphs.replace(paragraphs));

  ChapterContent._();

  Uri get url;

  String get title;

  BuiltList<String> get paragraphs;

  Uri get chapterListUrl;

  bool get isLocked;

  Future<ChapterList> fetchChapterList() => BookRepository.fetchChapterList(chapterListUrl);

  @nullable
  Uri get previousChapterUrl;

  bool get hasPrevious => previousChapterUrl != null;

  @nullable
  Uri get nextChapterUrl;

  bool get hasNext => nextChapterUrl != null;
}
