import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:reader/models/BookInfo.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/models/ChapterList.dart';
import 'package:reader/repositories/network/BookRepository.dart';

part 'BookEntry.g.dart';

abstract class BookEntry implements Built<BookEntry, BookEntryBuilder> {
  BookEntry._();

  factory BookEntry([updates(BookEntryBuilder b)]) = _$BookEntry;

  String get id;

  String get bookName;

  Uri get chapterListUrl;

  Uri get bookInfoUrl;

  @nullable
  Uri get currentChapterUrl; // TODO: Clean up

  bool get hasCurrentChapter => currentChapterUrl != null; // TODO: Clean up

  static Serializer<BookEntry> get serializer => _$bookEntrySerializer;

  Future<BookInfo> fetchBookInfo() => BookRepository.fetchBookInfo(bookInfoUrl);

  Future<ChapterList> fetchChapterList() =>
      BookRepository.fetchChapterList(chapterListUrl);

  Future<ChapterContent> fetchCurrentChapterContent() =>
      BookRepository.fetchChapterContent(currentChapterUrl);

  BookEntry updateCurrentChapterUrl(Uri contentUrl) {
    final builder = toBuilder();
    builder.currentChapterUrl = contentUrl;
    return builder.build();
  }
}
