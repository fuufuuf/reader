import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/presentations/screens/readingScreen/ChapterContentView.dart';
import 'package:reader/presentations/screens/readingScreen/ReadingScaffold.dart';
import 'package:reader/presentations/wrappers/ContentLoader.dart';
import 'package:reader/presentations/wrappers/ReadingThemeProvider.dart';
import 'package:reader/repositories/network/BookRepository.dart';
import 'package:screen/screen.dart';

class ReadingScreen extends StatefulWidget {
  final BookEntry bookEntry;
  final Uri contentUrl;

  const ReadingScreen({Key key, this.bookEntry, this.contentUrl})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _ReadingScreenState(bookEntry, contentUrl);
}

class _ReadingScreenState extends State<ReadingScreen> {
  final BookEntry bookEntry;

  Future<ChapterContent> future;

  _ReadingScreenState(this.bookEntry, Uri contentUrl) {
    future = BookRepository.fetchChapterContent(contentUrl);
  }


  @override
  void initState() {
    super.initState();
    _enableReadingMode();
  }

  @override
  void dispose() {
    _disableReadingMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      ReadingScaffold(
        readingTheme: ReadingThemeProvider.fetchTheme(context),
        onDoubleTap: _onDoubleTap,
          content: ContentLoader(
              future: future,
              render: (BuildContext context, ChapterContent chapterContent) =>
                  ChapterContentView(chapter: chapterContent)
          )
      );

  void _onDoubleTap(BuildContext context) {
  }

  void _enableReadingMode() {
    Screen.keepOn(true);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  void _disableReadingMode() {
    Screen.keepOn(false);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }
}
