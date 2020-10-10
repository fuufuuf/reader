import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:timnew_reader/app/UserException.dart';
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
  Future<BuiltList<ChapterRef>> load() async {
    final chapterList = await BookRepository.fetchChapterList(bookIndex.chapterListUrl);
    return chapterList.chapters;
  }

  int findCurrentChapterIndex() {
    final currentChapterUrl = bookIndex.currentChapter;
    if (currentChapterUrl == null) return null;

    final chapters = currentData;
    if (chapters == null) return null;

    final index = chapters.indexWhere((c) => c.url == currentChapterUrl);

    if (index == -1) throw UserException("未找到當前章節");

    return index;
  }
}
