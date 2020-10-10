import 'dart:async';

import 'package:timnew_reader/arch/Request.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/repositories/network/BookRepository.dart';

class ChapterContentRequest extends Request<ChapterContent> {
  final BookIndex bookIndex;
  Uri _currentUrl;

  factory ChapterContentRequest.fromChapterRef(BookIndex bookIndex, ChapterRef chapterRef) =>
      ChapterContentRequest(bookIndex, chapterRef.url);

  factory ChapterContentRequest.currentChapter(BookIndex bookIndex) {
    final currentChapterUrl = bookIndex.currentChapter;

    if (currentChapterUrl == null) return null;

    return ChapterContentRequest(bookIndex, currentChapterUrl);
  }

  ChapterContentRequest(this.bookIndex, Uri chapterUrl)
      : assert(bookIndex != null),
        assert(chapterUrl != null),
        _currentUrl = chapterUrl;

  @override
  Future<ChapterContent> load() async {
    return await BookRepository.fetchChapterContent(_currentUrl);
  }
}
