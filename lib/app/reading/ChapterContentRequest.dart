import 'dart:async';

import 'package:timnew_reader/arch/Request.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/repositories/network/BookRepository.dart';

class ChapterContentRequest extends Request<ChapterContent> {
  final BookIndex bookIndex;
  final Uri chapterUrl;

  factory ChapterContentRequest.fromChapterRef(BookIndex bookIndex, ChapterRef chapterRef) =>
      ChapterContentRequest._(bookIndex, chapterRef.url);

  factory ChapterContentRequest.currentChapter(BookIndex bookIndex) {
    final currentChapterUrl = bookIndex.currentChapter;

    if (currentChapterUrl == null) return null;

    return ChapterContentRequest._(bookIndex, currentChapterUrl);
  }

  ChapterContentRequest._(this.bookIndex, this.chapterUrl)
      : assert(bookIndex != null),
        assert(chapterUrl != null);

  @override
  Future<ChapterContent> load() async {
    final content = await BookRepository.fetchChapterContent(chapterUrl).timeout(Duration(seconds: 3));

    await bookIndex.setCurrentChapter(chapterUrl);

    return content;
  }

  bool get hasNextChapter => currentData?.hasNext ?? false;

  bool get hasPreviousChapter => currentData?.hasPrevious ?? false;
}
