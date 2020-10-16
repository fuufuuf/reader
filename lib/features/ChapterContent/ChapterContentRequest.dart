import 'dart:async';

import 'package:async/async.dart';
import 'package:timnew_reader/arch/Request.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/repositories/PersistentStorage.dart';
import 'package:timnew_reader/repositories/network/BookRepository.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ChapterContentWithScroll.dart';
import 'ScrollTarget.dart';

class ChapterContentRequest extends Request<ChapterContentWithScroll> {
  final BookIndex bookIndex;
  Uri _chapterUrl;
  ScrollTarget _scrollTarget;

  Uri get chapterUrl => _chapterUrl;

  factory ChapterContentRequest.fromChapterRef(BookIndex bookIndex, ChapterRef chapterRef) =>
      ChapterContentRequest._(bookIndex, chapterRef.url, ScrollTarget.top());

  factory ChapterContentRequest.currentChapter(BookIndex bookIndex) {
    if (!bookIndex.hasCurrentChapter) return null;

    return ChapterContentRequest._(bookIndex, bookIndex.currentChapterUrl, bookIndex.currentParagraph);
  }

  ChapterContentRequest._(this.bookIndex, Uri chapterUrl, ScrollTarget scrollTarget)
      : assert(bookIndex != null),
        assert(chapterUrl != null),
        assert(scrollTarget != null),
        _chapterUrl = chapterUrl,
        _scrollTarget = scrollTarget;

  @override
  Future<ChapterContentWithScroll> load() async {
    final content = await bookIndex.fetchChapterContent(chapterUrl).timeout(Duration(seconds: 5));

    await bookIndex.saveCurrentChapter(chapterUrl);

    return ChapterContentWithScroll(
      chapter: content,
      scrollTarget: _scrollTarget,
    );
  }

  Future<Result<ChapterContentWithScroll>> _updateUrl(Uri newUrl, ScrollTarget scrollTarget) {
    if (newUrl == null) return null;

    _chapterUrl = newUrl;
    _scrollTarget = scrollTarget;

    return reload();
  }

  bool get hasNextChapter => currentData?.hasNext ?? false;

  bool get hasPreviousChapter => currentData?.hasPrevious ?? false;

  Future<Result<ChapterContentWithScroll>> loadNextChapter() async =>
      _updateUrl(currentData?.nextChapterUrl, ScrollTarget.top());

  Future<Result<ChapterContentWithScroll>> loadPreviousChapter() async =>
      _updateUrl(currentData?.previousChapterUrl, ScrollTarget.bottom());

  void openCurrentChapterInExternalBrowser() async {
    if (currentData == null) {
      return;
    }

    final urlString = currentData.chapter.url.toString();

    if (await canLaunch(urlString)) {
      await launch(urlString, forceSafariVC: false, forceWebView: false);
    }
  }
}
