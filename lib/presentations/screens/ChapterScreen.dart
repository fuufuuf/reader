import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/models/Chapter.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';
import 'package:reader/presentations/providers/ReadingThemeProvider.dart';
import 'package:reader/presentations/screens/chapterScreen/ChapterContentView.dart';
import 'package:reader/presentations/screens/chapterScreen/ChapterScreenMenuSheet.dart';
import 'package:screen/screen.dart';

class ChapterScreen extends StatelessWidget {
  final Chapter chapter;

  ChapterScreen({@required this.chapter});

  @override
  Widget build(BuildContext context) {
    _enableReadingMode();
    return ScreenScaffold(
        backgroundColor: _backgroundColor(context),
        body: GestureDetector(
            onDoubleTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => ChapterScreenMenuSheet()
              );
            },
            child: ChapterContentView(chapter: chapter)
        )
    );
  }

  void _enableReadingMode() {
    Screen.keepOn(true);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  void _disableReadingMode() {
    Screen.keepOn(false);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  _backgroundColor(BuildContext context) =>
      ReadingThemeProvider
          .fetch(context)
          .theme
          .chapterViewBackgroundColor;
}
