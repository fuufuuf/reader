import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:screen/screen.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/presentations/components/readingScreen/ChapterContentView.dart';
import 'package:timnew_reader/presentations/components/readingScreen/OverScrollNavigator.dart';
import 'package:timnew_reader/presentations/components/readingScreen/ReadingPopUpMenu.dart';
import 'package:timnew_reader/presentations/components/readingScreen/ReadingScaffold.dart';
import 'package:timnew_reader/presentations/wrappers/ContentLoader.dart';
import 'package:timnew_reader/repositories/network/BookRepository.dart';

class ReadingScreen extends StatefulWidget {
  final BookIndex bookIndex;
  final Uri contentUrl;

  ReadingScreen({Key key, String bookId, this.contentUrl})
      :
        bookIndex = BookIndex.load(bookId),
        super(key: key);

  @override
  State<StatefulWidget> createState() =>
      ReadingScreenState(bookIndex, contentUrl);
}

class ReadingScreenState extends State<ReadingScreen> {

  final BookIndex bookIndex;

  Future<ChapterContent> future;
  ChapterContent currentContent;
  Uri _urlToLoad;

  ReadingScreenState(this.bookIndex, Uri contentUrl) {
    loadContent(contentUrl);
  }

  void loadContent(Uri contentUrl) {
    future = () async {
      currentContent = null;

      currentContent = await BookRepository.fetchChapterContent(contentUrl);

      await bookIndex.setCurrentChapter(contentUrl);

      setState(() {
        currentContent = currentContent; // Refresh data;
      });

      return currentContent;
    }();
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

  void _onStateChanged(OverScrollNavigatorMode mode) {
    switch (mode) {
      case OverScrollNavigatorMode.Loading:
        setState(() {
          if (_urlToLoad != null) {
            loadContent(_urlToLoad);
            _urlToLoad = null;
          }
        });
        break;
      case OverScrollNavigatorMode.UpArmed:
        _urlToLoad = currentContent.previousChapterUrl;
        break;
      case OverScrollNavigatorMode.DownArmed:
        _urlToLoad = currentContent.nextChapterUrl;
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) =>
      ReadingScaffold(
          onDoubleTap: _onDoubleTap,
          content: OverScrollNavigator(
            isLoading: currentContent == null,
            isUpEnabled: currentContent?.hasPrevious ?? false,
            isDownEnabled: currentContent?.hasNext ?? false,
            displacementThreshold: 100,
            onStateChanged: _onStateChanged,
            child: ContentLoader(
                future: future,
                respondToReloading: true,
                render: (BuildContext context, ChapterContent chapterContent) =>
                    ChapterContentView(
                        chapter: chapterContent
                    )
            ),
          )
      );

  void _onDoubleTap(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) =>
            ReadingPopUpMenu(this)
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
