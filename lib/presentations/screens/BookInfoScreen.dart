import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/models/Book.dart';
import 'package:reader/presentations/ReaderApp.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';

class BookInfoScreen extends StatelessWidget {
  final Book book;

  BookInfoScreen({this.book});

  Iterable<Widget> _buildItems(BuildContext context) sync* {
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
          ReaderApp.openUrl(context, book.menuUrl);
        },
      );
    }

    if (book.hasFirstChapter) {
      yield ListTile(
          key: Key('First Chapter Link'),
          leading: Icon(Icons.bookmark),
          title: const Text("最早章节"),
          onTap: () {
            ReaderApp.openUrl(context, book.firstChapterUrl);
          }
      );
    }

    if (book.hasLatestChapter) {
      yield ListTile(
          key: Key('Latest Chapter Link'),
          leading: Icon(Icons.bookmark),
          title: const Text("最新章节"),
          onTap: () {
            ReaderApp.openUrl(context, book.latestChapterUrl);
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) =>
      ScreenScaffold(
          title: book.title,
          body: ListView(children: _buildItems(context).toList(growable: false))
      );
}
