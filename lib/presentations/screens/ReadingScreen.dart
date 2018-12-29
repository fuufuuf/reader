import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/models/BookIndex.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/presentations/components/readingScreen/ChapterContentView.dart';
import 'package:reader/presentations/components/readingScreen/ReadingPopUpMenu.dart';
import 'package:reader/presentations/components/readingScreen/ReadingScaffold.dart';
import 'package:reader/presentations/wrappers/ContentLoader.dart';
import 'package:reader/repositories/network/BookRepository.dart';
import 'package:screen/screen.dart';

class ReadingScreen extends StatefulWidget {
  final String bookId;
  final Uri contentUrl;

  const ReadingScreen({Key key, this.bookId, this.contentUrl})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      ReadingScreenState(BookIndex.load(bookId), contentUrl);
}

class ReadingScreenState extends State<ReadingScreen> {
  static const double threshold = 100;

  final BookIndex bookIndex;

  Future<ChapterContent> future;
  ChapterContent currentContent;
  double _loadPreviousResistance = 0;
  double _loadNextResistance = 0;
  Uri _urlToLoadNext;

  ReadingScreenState(this.bookIndex, Uri contentUrl) {
    future = loadContent(contentUrl);
  }

  Future<ChapterContent> loadContent(Uri contentUrl) async {
    currentContent = null;
    currentContent = await BookRepository.fetchChapterContent(contentUrl);

    await bookIndex.setCurrentChapter(contentUrl);

    return currentContent;
  }

  @override
  void initState() {
    super.initState();
    _enableReadingMode();
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (currentContent == null) {
      _resetTriggerResistance();
      return true;
    }

    final metrics = notification.metrics;

    if (currentContent.hasNext &&
        metrics.pixels > metrics.maxScrollExtent) {
      setState(() {
        _loadNextResistance =
            _normalizeResistance(
                metrics.pixels - metrics.maxScrollExtent, threshold);

        if (_loadNextResistance >= 1.0) {
          _loadNextResistance = 0;
          _urlToLoadNext = currentContent.nextChapterUrl;
        }
      });
    } else if (currentContent.hasPrevious &&
        metrics.pixels < metrics.minScrollExtent) {
      setState(() {
        _loadPreviousResistance =
            _normalizeResistance(
                metrics.minScrollExtent - metrics.pixels, threshold);

        if (_loadPreviousResistance >= 1.0) {
          _loadPreviousResistance = 0;
          _urlToLoadNext = currentContent.previousChapterUrl;
        }
      });
    } else {
      _resetTriggerResistance();
    }

    if (notification is ScrollUpdateNotification &&
        notification.dragDetails == null) {
      _tryLoadContent();
      return true;
    }

    if (notification is ScrollEndNotification) {
      _tryLoadContent();
      return true;
    }

    return true;
  }

  void _tryLoadContent() {
    if (_urlToLoadNext != null) {
      setState(() {
        future = loadContent(_urlToLoadNext);
        _urlToLoadNext = null;
      });
    }
  }

  double _normalizeResistance(double value, double threshold) {
    if (value < 0) {
      return 0;
    }

    if (value > threshold) {
      return 1;
    }

    return value / threshold;
  }

  void _resetTriggerResistance() {
    if (_loadPreviousResistance > 0 || _loadNextResistance > 0) {
      setState(() {
        _loadPreviousResistance = 0;
        _loadNextResistance = 0;
      });
    }
  }

  @override
  void dispose() {
    _disableReadingMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      ReadingScaffold(
          onDoubleTap: _onDoubleTap,
          content:
          Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.topCenter,
                  child: Opacity(opacity: _loadPreviousResistance,
                      child: const Icon(Icons.arrow_upward))
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Opacity(
                  opacity: _loadNextResistance,
                  child: const Icon(Icons.arrow_downward),),
              ),
              NotificationListener<ScrollNotification>(
                  onNotification: _onScrollNotification,
                  child: ContentLoader(
                      future: future,
                      respondToReloading: true,
                      render: (BuildContext context,
                          ChapterContent chapterContent) =>
                          ChapterContentView(
                              chapter: chapterContent)
                  )
              )

            ],
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
