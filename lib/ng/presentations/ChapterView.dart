import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/ng/events/EventBus.dart';
import 'package:reader/ng/events/OpenUrlEvent.dart';
import 'package:reader/ng/events/SwitchNightModeEvent.dart';
import 'package:reader/ng/models/Chapter.dart';
import 'package:reader/ng/models/ReadingTheme.dart';
import 'package:reader/ng/presentations/ChapterContentView.dart';
import 'package:reader/ng/presentations/ReadingThemeProvider.dart';
import 'package:screen/screen.dart';

class ChapterView extends StatelessWidget {
  final Chapter chapter;

  ChapterView({@required this.chapter});

  @override
  Widget build(BuildContext context) {
    _enableReadingMode();
    return _buildWithTheme(
        context, ReadingThemeProvider.fetchReadingTheme(context));
  }

  Widget _buildWithTheme(BuildContext context, ReadingTheme theme) =>
      Scaffold(
          backgroundColor: theme.chapterViewBackgroundColor,
          body: GestureDetector(
              onDoubleTap: () async {
                showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        BottomSheet(
                            onClosing: () {},
                            builder: (BuildContext menuContext) =>
                                _renderMenuWithTheme(menuContext, theme)
                        )
                );
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ChapterContentView(chapter: chapter),
              )
          )
      );

  Widget _renderMenuWithTheme(BuildContext context, ReadingTheme theme) =>
      ListView(children: <Widget>[
        ListTile(
            leading: const Icon(Icons.navigate_next),
            title: const Text("Next Chapter"),
            enabled: chapter.hasNext,
            onTap: _gotoNext),
        ListTile(
          leading: const Icon(Icons.navigate_before),
          title: const Text("Previous Chapter"),
          enabled: chapter.hasPrevious,
          onTap: _gotoPrevious,
        ),
        ListTile(
          leading: const Icon(Icons.list),
          title: const Text("Menu"),
          enabled: chapter.hasMenu,
          onTap: _gotoMenu,
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Book'),
          enabled: chapter.hasBook,
          onTap: _gotoBook,
        ),
        ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text("Reload Chapter"),
            onTap: _reload),
        ListTile(
            leading: theme.isNightMode
                ? const Icon(Icons.brightness_3)
                : const Icon(Icons.brightness_7),
            title: const Text("Night Mode"),
            onTap: () {
              _toggleNightMode(theme);
            })
      ]);

  void _gotoNext() {
    EventBus.post(OpenUrlEvent(chapter.nextChapterUrl));
  }

  void _gotoPrevious() {
    EventBus.post(OpenUrlEvent(chapter.previousChapterUrl));
  }

  void _enableReadingMode() {
    Screen.keepOn(true);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  void _disableReadingMode() {
    Screen.keepOn(false);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  void _gotoBook() {
    _disableReadingMode();
    EventBus.post(OpenUrlEvent(chapter.bookUrl));
  }

  void _gotoMenu() {
    _disableReadingMode();
    EventBus.post(OpenUrlEvent(chapter.menuUrl));
  }

  void _reload() {
    EventBus.post(OpenUrlEvent(chapter.url));
  }

  void _toggleNightMode(ReadingTheme theme) {
    EventBus.post(SwitchNightModeEvent(!theme.isNightMode));
  }
}
