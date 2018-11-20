import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reader/models/models.dart';
import 'package:screen/screen.dart';

class ReaderScreen extends StatefulWidget {
  final Book book;
  final int chapterIndex;

  ReaderScreen(this.book, this.chapterIndex);

  @override
  State<StatefulWidget> createState() => _ReaderScreenState(chapterIndex);
}

class _ReaderScreenState extends State<ReaderScreen> {
  Book get book => widget.book;

  Chapter get chapterFromBook => book.chapters[chapterIndex];

  int chapterIndex;
  Future<Chapter> future;

  bool get hasPrevious => chapterIndex > 0;

  bool get hasNext => chapterIndex < book.chapters.length - 1;

  _ReaderScreenState(this.chapterIndex);

  @override
  void initState() {
    super.initState();
    _createFuture();
    Screen.keepOn(false);
  }

  _createFuture({bool reload: false}) {
    future = chapterFromBook.load(reload: reload);
  }

  @override
  void deactivate() {
    super.deactivate();
    Screen.keepOn(false);
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
      ]);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GestureDetector(
          onDoubleTap: () async {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BottomSheet(
                      onClosing: () {}, builder: renderBottomSheet);
                });
          },
          child: _ChapterLoader(future),
        ),
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
          textAlign: TextAlign.left,
        ),
      );
}

class _ChapterTitle extends StatelessWidget {
  final String title;

  _ChapterTitle(this.title);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          title,
          textAlign: TextAlign.center,
          textScaleFactor: 2.0,
        ),
      );
}
