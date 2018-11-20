import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reader/models/models.dart';
import 'package:screen/screen.dart';

class ReaderScreen extends StatefulWidget {
  final Book book;
  final int chapterIndex;

  ReaderScreen(this.book, this.chapterIndex);

  @override
  State<StatefulWidget> createState() =>
      _ReaderScreenState(chapterIndex, false);
}

class _ReaderScreenState extends State<ReaderScreen> {
  Book get book => widget.book;

  Chapter get chapterFromBook => book.chapters[chapterIndex];

  int chapterIndex;
  Future<Chapter> future;

  bool get hasPrevious => chapterIndex > 0;

  bool get hasNext => chapterIndex < book.chapters.length - 1;

  bool nightMode;

  _ReaderScreenState(this.chapterIndex, this.nightMode);

  @override
  void initState() {
    super.initState();
    _createFuture();
    Screen.keepOn(false);

    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  _createFuture({bool reload: false}) {
    future = chapterFromBook.load(reload: reload);
  }

  Widget renderBottomSheet(BuildContext context) => ListView(children: <Widget>[
        ListTile(
            leading: const Icon(Icons.navigate_next),
            title: const Text("Next Chapter"),
            enabled: hasNext,
            onTap: onNextChapter),
        ListTile(
          leading: const Icon(Icons.navigate_before),
          title: const Text("Previous Chapter"),
          enabled: hasPrevious,
          onTap: onPreviousChapter,
        ),
        ListTile(
            leading: const Icon(Icons.note),
            title: const Text("Chapters"),
            onTap: () {
              Screen.keepOn(false);
              SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
              Navigator.pop(context);
              Navigator.pop(context, chapterIndex);
            }),
        ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text("Reload Chapter"),
            onTap: reloadChapter),
        ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text("Refresh Book"),
            onTap: refreshBook),
        ListTile(
            leading: nightMode
                ? const Icon(Icons.brightness_3)
                : const Icon(Icons.brightness_7),
            title: const Text("Night Mode"),
            onTap: toggleNightMode),
      ]);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor:
            nightMode ? Colors.black : const Color.fromARGB(255, 210, 180, 140),
        body: GestureDetector(
            onDoubleTap: () async {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BottomSheet(
                        onClosing: () {}, builder: renderBottomSheet);
                  });
            },
            child: _DarkModePublisher(
              nightMode: nightMode,
              child: _ChapterLoader(future),
            )),
      );

  void onNextChapter() {
    if (hasNext) {
      setState(() {
        chapterIndex++;
        _createFuture();
      });
    }
    Navigator.pop(context);
  }

  void onPreviousChapter() {
    if (hasPrevious) {
      setState(() {
        chapterIndex--;
        _createFuture();
      });
    }
    Navigator.pop(context);
  }

  void reloadChapter() {
    setState(() {
      _createFuture(reload: true);
    });
    Navigator.pop(context);
  }

  void refreshBook() {
    setState(() {
      future = book
          .load(reload: true)
          .then((book) => book.chapters[chapterIndex].load());
    });
    Navigator.pop(context);
  }

  void toggleNightMode() {
    setState(() {
      nightMode = !nightMode;
    });
    Navigator.pop(context);
  }
}

class _DarkModePublisher extends InheritedWidget {
  final bool nightMode;

  _DarkModePublisher({Key key, this.nightMode, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static bool isNightMode(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(_DarkModePublisher)
              as _DarkModePublisher)
          .nightMode;
}

class _ChapterLoader extends StatelessWidget {
  final Future<Chapter> future;

  _ChapterLoader(this.future);

  @override
  Widget build(BuildContext context) => FutureBuilder<Chapter>(
        future: future,
        builder: renderLoader,
      );

  Widget renderLoader(BuildContext context, AsyncSnapshot<Chapter> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const Center(child: Text("Loading"));
    }

    if (snapshot.hasError) {
      debugger();
      throw snapshot.error;
    }

    return _LongTextView(snapshot.data);
  }
}

class _LongTextView extends StatelessWidget {
  final Chapter chapter;

  _LongTextView(this.chapter);

  Widget _renderParagraph(BuildContext context, int index) => index == 0
      ? _ChapterTitle(chapter.title)
      : _Paragraph(chapter.content[index - 1]);

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemBuilder: _renderParagraph, itemCount: chapter.content.length + 1);
}

class _Paragraph extends StatelessWidget {
  final String content;

  _Paragraph(this.content);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          content,
          style: _applyStyle(context),
          textAlign: TextAlign.left,
        ),
      );

  TextStyle _applyStyle(BuildContext context) {
    if (_DarkModePublisher.isNightMode(context)) {
      return DefaultTextStyle.of(context).style.apply(color: Colors.white10);
    } else
      return null;
  }
}

class _ChapterTitle extends StatelessWidget {
  final String title;

  _ChapterTitle(this.title);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          title,
          style: _applyStyle(context),
          textAlign: TextAlign.center,
          textScaleFactor: 2.0,
        ),
      );

  TextStyle _applyStyle(BuildContext context) {
    if (_DarkModePublisher.isNightMode(context)) {
      return DefaultTextStyle.of(context).style.apply(color: Colors.white10);
    } else
      return null;
  }
}
