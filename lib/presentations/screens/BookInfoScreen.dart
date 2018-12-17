import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/models/BookInfo.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';
import 'package:reader/presentations/wrappers/ContentOwner.dart';

class BookInfoScreen extends StatelessWidget {
  final Future<BookEntry> bookEntry;
  final ContentController<BookInfo> controller;

  BookInfoScreen({Key key, this.bookEntry})
      :
        controller = ContentController(
          initialFuture: bookEntry.then((entry) => entry.fetchBookInfo()),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) =>
      ScreenScaffold(
        title: '???',
        body: ContentOwner<BookInfo>(
            controller: controller,
            render: (BuildContext context, BookInfo bookInfo) =>
                BookInfoView(bookInfo: bookInfo)
        ),
      );
}

class BookInfoView extends StatelessWidget {
  final BookInfo bookInfo;

  BookInfoView({this.bookInfo});

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
      ListView(children: _buildItems(context).toList(growable: false));
}
