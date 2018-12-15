import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/models/BookInfo.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';

class BookInfoScreen extends StatelessWidget {
  final BookInfo book;

  BookInfoScreen({this.book});

  Iterable<Widget> _buildItems(BuildContext context) sync* {
    if (book.hasAuthor) {
      yield ListTile(key: Key('author'),
          leading: Icon(Icons.person),
          title: Text('作者： ${book.author}'));
    }

    if (book.hasGenre) {
      yield ListTile(key: Key('genre'),
          leading: Icon(Icons.category),
          title: Text('类型： ${book.genre}'));
    }

    if (book.hasCompleteness) {
      yield ListTile(key: Key('completeness'),
          leading: Icon(Icons.more),
          title: Text('状态： ${book.completeness}'));
    }

    if (book.hasLastUpdated) {
      yield ListTile(key: Key('lastUpdated'),
          leading: Icon(Icons.access_time),
          title: Text('最近更新时间： ${book.lastUpdated}'));
    }

    if (book.hasLength) {
      yield ListTile(key: Key('length'),
          leading: Icon(Icons.translate),
          title: Text('总字数： ${book.lastUpdated}'));
    }
  }

  @override
  Widget build(BuildContext context) =>
      ScreenScaffold(
          title: book.title,
          body: ListView(children: _buildItems(context).toList(growable: false))
      );
}
