import 'package:flutter/material.dart';
import 'package:timnew_reader/app/BookInfo/BookInfoScreen.dart';
import 'package:timnew_reader/app/ChapterList/ChapterListScreen.dart';
import 'package:timnew_reader/app/reading/ChapterContentRequest.dart';
import 'package:timnew_reader/app/reading/ReadingScreen.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/ChapterRef.dart';

class AppRouter {
  static NavigatorState of(BuildContext context) => Navigator.of(context);
}

extension NaivigatorStateRoutingExtension on NavigatorState {
  Future goToBookContent(BookIndex bookIndex) {
    final firstNavigationResult = push(ChapterListScreen.buildRoute(bookIndex));

    var currentChapterRequest = ChapterContentRequest.currentChapter(bookIndex);
    if (currentChapterRequest != null) {
      push(ReadingScreen.buildRoute(currentChapterRequest));
    }

    return firstNavigationResult;
  }

  Future goToChapterList(BookIndex bookIndex) {
    return push(ChapterListScreen.buildRoute(bookIndex));
  }

  Future gotoBookInfo(BookIndex bookIndex) {
    return push(BookInfoScreen.buildRoute(bookIndex));
  }

  Future gotoChapterContent(BookIndex bookIndex, ChapterRef chapterRef) {
    var request = ChapterContentRequest.fromChapterRef(bookIndex, chapterRef);
    return push(ReadingScreen.buildRoute(request));
  }
}
