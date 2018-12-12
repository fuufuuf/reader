import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/ng/events/EventBus.dart';
import 'package:reader/ng/events/OpenUrlEvent.dart';
import 'package:reader/ng/models/Book.dart';
import 'package:reader/ng/models/ReadingTheme.dart';
import 'package:reader/ng/presentations/ReadingThemeProvider.dart';

class BookView extends StatelessWidget {
  final Book book;
  final List<Widget> _items;

  BookView({Book book})
      : book = book,
        _items =_buildItems(book).toList(growable: false);

  static Iterable<Widget> _buildItems(Book book) sync* {
    if (book.hasAuthor) {
      yield ListTile(key: Key('author'),
          leading: Icon(Icons.person),
          title: Text('作者： ${book.author}'));
    }

    if (book.hasMenu) {
      yield ListTile(
        key: Key('Menu Link'),
        leading: Icon(Icons.list),
        title: const Text("目录"),
        onTap: () {
          EventBus.post(OpenUrlEvent(book.menuUrl));
        },
      );
    }

    if (book.hasFirstChapter) {
      yield ListTile(
          key: Key('First Chapter Link'),
          leading: Icon(Icons.bookmark),
          title: const Text("最早章节"),
          onTap: () {
            EventBus.post(OpenUrlEvent(book.firstChapterUrl));
          }
      );
    }

    if (book.hasLatestChapter) {
      yield ListTile(
          key: Key('Latest Chapter Link'),
          leading: Icon(Icons.bookmark),
          title: const Text("最新章节"),
          onTap: () {
            EventBus.post(OpenUrlEvent(book.latestChapterUrl));
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) =>
      _buildWithTheme(context, ReadingThemeProvider.fetchReadingTheme(context));

  Widget _buildWithTheme(BuildContext context,
      ReadingTheme theme) =>
      Scaffold(
          appBar: AppBar(
            title: Text(book.title),
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: ListView(children: _items)
          )
      );
}
