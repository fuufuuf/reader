import 'dart:async';

import 'package:async/async.dart';
import 'package:timnew_reader/arch/Request.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/repositories/network/BookRepository.dart';
import 'package:timnew_reader/repositories/settings/BookIndexRepository.dart';

class ChapterContentRequest extends Request<ChapterContent> {
  final BookIndex bookIndex;
  Uri _chapterUrl;

  Uri get chapterUrl => _chapterUrl;

  factory ChapterContentRequest.fromChapterRef(BookIndex bookIndex, ChapterRef chapterRef) =>
      ChapterContentRequest._(bookIndex, chapterRef.url);

  factory ChapterContentRequest.currentChapter(BookIndex bookIndex) {
    final currentChapterUrl = BookIndexRepository.loadCurrentChapter(bookIndex.bookId);

    if (currentChapterUrl == null) return null;

    return ChapterContentRequest._(bookIndex, currentChapterUrl);
  }

  ChapterContentRequest._(this.bookIndex, Uri chapterUrl)
      : assert(bookIndex != null),
        assert(chapterUrl != null),
        _chapterUrl = chapterUrl;

  @override
  Future<ChapterContent> load() async {
    final content = await bookIndex.fetchChapterContent(chapterUrl).timeout(Duration(seconds: 5));

    await BookIndexRepository.saveCurrentChapter(bookIndex.bookId, chapterUrl);

    return content;
  }

  Future<Result<ChapterContent>> _updateUrl(Uri newUrl) {
    if (newUrl == null) return null;

    _chapterUrl = newUrl;

    return reload();
  }

  bool get hasNextChapter => currentData?.hasNext ?? false;

  bool get hasPreviousChapter => currentData?.hasPrevious ?? false;

  Future<Result<ChapterContent>> loadNextChapter() {
    return _updateUrl(currentData?.nextChapterUrl);
  }

  Future<Result<ChapterContent>> loadPreviousChapter() {
    return _updateUrl(currentData?.previousChapterUrl);
  }
}
