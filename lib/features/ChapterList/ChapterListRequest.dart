import 'dart:async';

import 'package:built_collection/built_collection.dart';

import 'package:timnew_reader/features/App/common.dart';
import 'package:timnew_reader/arch/Request.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/repositories/PersistentStorage.dart';
import 'package:timnew_reader/repositories/network/BookRepository.dart';

class ChapterListRequest extends Request<BuiltList<ChapterRef>> {
  final BookIndex bookIndex;

  ChapterListRequest(this.bookIndex);

  String get bookId => bookIndex.bookId;

  String get bookName => bookIndex.bookName;

  @override
  Future<BuiltList<ChapterRef>> load() async {
    final chapterList = await bookIndex.fetchChapterList();
    return chapterList.chapters;
  }

  int findCurrentChapterIndex() {
    if (!bookIndex.hasCurrentChapter) return null;

    final chapters = currentData;
    if (chapters == null) return null;

    final index = chapters.indexWhere((c) => c.url == bookIndex.currentChapterUrl);

    if (index == -1) throw UserException("未找到當前章節");

    return index;
  }
}
