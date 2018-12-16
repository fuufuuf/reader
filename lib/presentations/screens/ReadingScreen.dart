import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/presentations/ReaderApp.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';
import 'package:reader/presentations/wrappers/ReadingThemeProvider.dart';
import 'package:reader/presentations/screens/readingScreen/ChapterContentView.dart';
import 'package:reader/presentations/screens/readingScreen/ReadingStatusBar.dart';
import 'package:screen/screen.dart';

class ReadingScreen extends StatelessWidget {
  final ChapterContent chapterContent;

  ReadingScreen({@required this.chapterContent});

  @override
  Widget build(BuildContext context) {
    _enableReadingMode();

    return
      ScreenScaffold(
          readingTheme: ReadingThemeProvider.fetchTheme(context),
          onDoubleTap: _onDoubleTap,
          body:
          Column(
            children: <Widget>[
              ReadingStatusBar(),
              Expanded(
                  key: Key('ChapterContent'),
                  child: ChapterContentView(chapter: chapterContent)
              )
            ],
          )

      );
  }

  void _onDoubleTap(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext menuContext) => _buildMenu(context)
    );
  }

  Widget _buildMenu(BuildContext context) {
    final themeProvider = ReadingThemeProvider.of(context);

    return BottomSheet(
        key: const Key('ChapterScreenMenuSheet'),
        onClosing: () {},
        builder: (BuildContext menuContext) =>
            ListView(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.navigate_next),
                      title: const Text("Next Chapter"),
                      enabled: chapterContent.hasNext,
                      onTap: () {
                        Navigator.pop(menuContext);
                        Navigator.pop(context);
                        ReaderApp.openUrl(context, chapterContent.nextChapterUrl);
                      }),
                  ListTile(
                    leading: const Icon(Icons.navigate_before),
                    title: const Text("Previous Chapter"),
                    enabled: chapterContent.hasPrevious,
                    onTap: () {
                      Navigator.pop(menuContext);
                      Navigator.pop(context);
                      ReaderApp.openUrl(context, chapterContent.previousChapterUrl);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text("Menu"),
                    onTap: () {
                      _disableReadingMode();
                      Navigator.pop(menuContext);
                      Navigator.pop(context);
                      ReaderApp.openUrl(context, chapterContent.chapterListUrl);
                    },
                  ),
                  ListTile(
                      leading: const Icon(Icons.refresh),
                      title: const Text("Reload Chapter"),
                      onTap: () {
                        Navigator.pop(menuContext);
                        Navigator.pop(context);
                        ReaderApp.openUrl(context, chapterContent.url);
                      }),
                  ListTile(
                    leading: const Icon(Icons.keyboard_return),
                    title: const Text("Return"),
                    onTap: () {
                      Navigator.pop(menuContext);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                      leading: themeProvider.theme.isNightMode
                          ? const Icon(Icons.brightness_3)
                          : const Icon(Icons.brightness_7),
                      title: const Text("Night Mode"),
                      onTap: () {
                        Navigator.pop(menuContext);
                        themeProvider.switchTheme(
                            !themeProvider.theme.isNightMode);
                      })
                ]
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
