import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/events/EventBus.dart';
import 'package:reader/events/OpenUrlEvent.dart';
import 'package:reader/models/Book.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';

class BookInfoScreen extends StatelessWidget {
  final Book book;
  final List<Widget> _items;

  BookInfoScreen({Book book})
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
      ScreenScaffold(
          appBar: AppBar(
            title: Text(book.title),
          ),
          body: ListView(children: _items)
      );
}
