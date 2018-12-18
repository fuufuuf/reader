import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/presentations/screens/readingScreen/ReadingScaffold.dart';
import 'package:reader/presentations/wrappers/ReadingThemeProvider.dart';
import 'package:screen/screen.dart';

class ReadingScreen extends StatefulWidget {
  final BookEntry bookEntry;

  const ReadingScreen({Key key, this.bookEntry}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _ReadingScreenState(bookEntry);
}

class _ReadingScreenState extends State<ReadingScreen> {
  final BookEntry bookEntry;

  _ReadingScreenState(this.bookEntry);


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
        content: null
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
