import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:timnew_reader/arch/Request.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/repositories/network/BookRepository.dart';

class ChapterListRequest extends Request<BuiltList<ChapterRef>> {
  final BookIndex bookIndex;

  ChapterListRequest(this.bookIndex);

  String get bookId => bookIndex.bookId;

  String get bookName => bookIndex.bookName;

  @override
  Future<BuiltList<ChapterRef>> execute() async {
    final chapterList = await BookRepository.fetchChapterList(bookIndex.chapterListUrl);
    return chapterList.chapters;
  }
}
