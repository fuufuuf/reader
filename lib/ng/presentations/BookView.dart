import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/ng/events/EventBus.dart';
import 'package:reader/ng/events/OpenUrlEvent.dart';
import 'package:reader/ng/models/Book.dart';
import 'package:reader/ng/models/ReadingTheme.dart';
import 'package:reader/ng/presentations/ReadingThemeProvider.dart';

class BookView extends StatelessWidget {
  final Book book;

  BookView({this.book});

  @override
  Widget build(BuildContext context) =>
      _renderWithTheme(
          context, ReadingThemeProvider.fetchReadingTheme(context));

  Widget _renderWithTheme(BuildContext context, ReadingTheme theme) =>
      Scaffold(
          appBar: AppBar(
            title: Text(book.title),
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                children: List.of(buttons(), growable: false),
              )
          )
      );

  Iterable<Widget> buttons() sync* {
    yield Text("作者： ${book.author}");

    if (book.hasMenu) {
      yield RaisedButton(
          child: const Text("Menu"),
          onPressed: () {
            EventBus.post(OpenUrlEvent(book.menuUrl));
          }
      );
    }

    if (book.hasFirstChapter) {
      yield RaisedButton(
          child: const Text("First Page"),
          onPressed: () {
            EventBus.post(OpenUrlEvent(book.firstChapterUrl));
          }
      );
    }

    if (book.hasLatestChapter) {
      yield RaisedButton(
          child: const Text("Latest Page"),
          onPressed: () {
            EventBus.post(OpenUrlEvent(book.latestChapterUrl));
          }
      );
    }
  }
}
