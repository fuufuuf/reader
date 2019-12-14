import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'book_models.g.dart';

abstract class BookIndex implements Built<BookIndex, BookIndexBuilder> {
  BookIndex._();

  factory BookIndex([updates(BookIndexBuilder b)]) = _$BookIndex;

  static Serializer<BookIndex> get serializer => _$bookIndexSerializer;

  String get id;

  String get title;

  Uri get chapterListUrl;

  Uri get bookInfoUrl;
}

abstract class BookInfo implements Built<BookInfo, BookInfoBuilder> {
  BookInfo._();

  factory BookInfo([updates(BookInfoBuilder b)]) = _$BookInfo;

  @nullable
  String get author;

  @nullable
  String get genre;

  @nullable
  String get completeness;

  @nullable
  String get lastUpdated;

  @nullable
  String get length;

  bool get hasAuthor => author != null;

  bool get hasGenre => genre != null;

  bool get hasCompleteness => completeness != null;

  bool get hasLastUpdated => lastUpdated != null;

  bool get hasLength => length != null;

  BookIndex toBookIndex() =>
      BookIndex((b) =>
      b
        ..title
      );
}

abstract class ChapterRef implements Built<ChapterRef, ChapterRefBuilder> {
  ChapterRef._();

  factory ChapterRef([updates(ChapterRefBuilder b)]) = _$ChapterRef;

  Uri get url;

  String get title;
}

abstract class ChapterContent
    implements Built<ChapterContent, ChapterContentBuilder> {
  ChapterContent._();

  factory ChapterContent([updates(ChapterContentBuilder b)]) = _$ChapterContent;

  BuiltList<String> get paragraphs;

  @nullable
  Uri get previousChapterUrl;

  bool get hasPrevious => previousChapterUrl != null;

  @nullable
  Uri get nextChapterUrl;

  bool get hasNext => nextChapterUrl != null;

  bool get isLocked;
}
