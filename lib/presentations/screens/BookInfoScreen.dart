import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/models/BookInfo.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';

class BookInfoScreen extends StatelessWidget {
  final BookInfo bookInfo;

  BookInfoScreen({this.bookInfo});

  Iterable<Widget> _buildItems(BuildContext context) sync* {
    if (bookInfo.hasAuthor) {
      yield ListTile(key: Key('author'),
          leading: Icon(Icons.person),
          title: Text('作者： ${bookInfo.author}'));
    }

    if (bookInfo.hasGenre) {
      yield ListTile(key: Key('genre'),
          leading: Icon(Icons.category),
          title: Text('类型： ${bookInfo.genre}'));
    }

    if (bookInfo.hasCompleteness) {
      yield ListTile(key: Key('completeness'),
          leading: Icon(Icons.more),
          title: Text('状态： ${bookInfo.completeness}'));
    }

    if (bookInfo.hasLastUpdated) {
      yield ListTile(key: Key('lastUpdated'),
          leading: Icon(Icons.access_time),
          title: Text('最近更新时间： ${bookInfo.lastUpdated}'));
    }

    if (bookInfo.hasLength) {
      yield ListTile(key: Key('length'),
          leading: Icon(Icons.translate),
          title: Text('总字数： ${bookInfo.lastUpdated}'));
    }
  }

  @override
  Widget build(BuildContext context) =>
      ScreenScaffold(
          title: bookInfo.title,
          body: ListView(children: _buildItems(context).toList(growable: false))
      );
}
