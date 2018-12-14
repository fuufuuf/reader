import 'package:flutter/material.dart';
import 'package:reader/events/EventBus.dart';
import 'package:reader/events/OpenUrlEvent.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/presentations/providers/ReadingThemeProvider.dart';

class ReadingMenu extends StatelessWidget {
  final ChapterContent chapter;
  final ReadingThemeProvider themeProvider;

  const ReadingMenu({@required this.chapter, @required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      key: const Key('ChapterScreenMenuSheet'),
      onClosing: () {},
      builder: (BuildContext menuContext) =>
          ListView(
              children: <Widget>[
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
                    leading: themeProvider.theme.isNightMode
                        ? const Icon(Icons.brightness_3)
                        : const Icon(Icons.brightness_7),
                    title: const Text("Night Mode"),
                    onTap: () {
                      themeProvider.switchTheme(
                          !themeProvider.theme.isNightMode);
                    })
              ]
          )
    );
  }
  void _gotoNext() {
    EventBus.post(OpenUrlEvent(chapter.nextChapterUrl));
  }

  void _gotoPrevious() {
    EventBus.post(OpenUrlEvent(chapter.previousChapterUrl));
  }

  void _gotoBook() {
//    _disableReadingMode();
    EventBus.post(OpenUrlEvent(chapter.bookUrl));
  }

  void _gotoMenu() {
//    _disableReadingMode();
    EventBus.post(OpenUrlEvent(chapter.menuUrl));
  }

  void _reload() {
    EventBus.post(OpenUrlEvent(chapter.url));
  }
}
