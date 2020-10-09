import 'package:flutter/material.dart';
import 'package:timnew_reader/app/ChapterList/ChapterListScreen.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/ChapterRef.dart';

class AppRouter {
  static NavigatorState of(BuildContext context) => Navigator.of(context);
}

extension NaivigatorStateRoutingExtension on NavigatorState {
  static NavigatorState of(BuildContext context) => Navigator.of(context);

  Future openBook(BookIndex bookIndex) {
    final resultFuture = push(ChapterListScreen.buildRoute(bookIndex));

    if (bookIndex.hasCurrentChapter) {
      // push reading
    }

    return resultFuture;
  }

  Future openBookInfo(BookIndex bookIndex) {}

  Future openReader(BookIndex bookIndex, ChapterRef chapter) {}
}
