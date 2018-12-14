import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';
import 'package:reader/presentations/providers/ReadingThemeProvider.dart';
import 'package:reader/presentations/screens/readingScreen/ChapterContentView.dart';
import 'package:reader/presentations/screens/readingScreen/ReadingMenu.dart';
import 'package:screen/screen.dart';

class ReadingScreen extends StatelessWidget {
  final ChapterContent chapter;

  ReadingScreen({@required this.chapter});

  @override
  Widget build(BuildContext context) {
    _enableReadingMode();

    return
      ScreenScaffold(
          readingTheme: ReadingThemeProvider.fetchTheme(context),
          onDoubleTap: _onDoubleTap,
          body: ChapterContentView(chapter: chapter)
      );
  }

  void _onDoubleTap(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext menuContext) =>
            ReadingMenu(
                chapter: chapter,
                themeProvider: ReadingThemeProvider.fetch(context)
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
}
