import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/repositories/network/BookRepository.dart';

part 'ChapterContent.g.dart';

abstract class ChapterContent
    implements Built<ChapterContent, ChapterContentBuilder> {
  ChapterContent._();

  factory ChapterContent([updates(ChapterContentBuilder b)]) = _$ChapterContent;

  Uri get url;

  Future<ChapterContent> reload() => BookRepository.fetchChapterContent(url);

  String get title;

  BuiltList<String> get paragraphs;

  Uri get chapterListUrl;

  Future<ChapterList> fetchChapterList() =>
      BookRepository.fetchChapterList(chapterListUrl);

  @nullable
  Uri get previousChapterUrl;

  bool get hasPrevious => previousChapterUrl != null;

  Future<ChapterContent> fetchPreviousChapter() =>
      BookRepository.fetchChapterContent(previousChapterUrl);

  @nullable
  Uri get nextChapterUrl;

  bool get hasNext => nextChapterUrl != null;

  Future<ChapterContent> fetchNextChapter() =>
      BookRepository.fetchChapterContent(nextChapterUrl);
}
