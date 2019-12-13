import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../models/BookIndex.dart';
import '../../models/BookInfo.dart';
import '../../presentations/components/ScreenScaffold.dart';
import '../../presentations/wrappers/ContentLoader.dart';

class BookInfoScreen extends StatelessWidget {
  final BookIndex bookIndex;

  BookInfoScreen({Key key, String bookId})
      :
        bookIndex = BookIndex.load(bookId),
        super(key: key);

  @override
  Widget build(BuildContext context) =>
      ScreenScaffold(
        title: bookIndex.bookName,
        body: ContentLoader<BookInfo>(
            future: bookIndex.fetchBookInfo(),
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
