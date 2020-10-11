import 'package:flutter/material.dart';
import 'package:timnew_reader/features/BookInfo/BookInfoScreen.dart';
import 'package:timnew_reader/features/ChapterContent/ChapterContentRequest.dart';
import 'package:timnew_reader/features/ChapterContent/ChapterContentScreen.dart';
import 'package:timnew_reader/features/ChapterList/ChapterListScreen.dart';

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
      push(ChapterContentScreen.buildRoute(currentChapterRequest));
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
    return push(ChapterContentScreen.buildRoute(request));
  }
}
