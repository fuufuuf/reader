import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import './BookInfo.dart';
import './ChapterRef.dart';
import '../repositories/network/BookRepository.dart';

part 'ChapterList.g.dart';

abstract class ChapterList implements Built<ChapterList, ChapterListBuilder> {
  ChapterList._();

  factory ChapterList([updates(ChapterListBuilder b)]) = _$ChapterList;

  Uri get url;

  Future<ChapterList> reload() => BookRepository.fetchChapterList(url);

  String get title;

  Uri get bookInfoUrl;

  Future<BookInfo> fetchBookInfo() => BookRepository.fetchBookInfo(bookInfoUrl);

  BuiltList<ChapterRef> get chapters;
}
