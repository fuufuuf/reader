import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timnew_reader/app/BookInfo/BookInfoRequest.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/BookInfo.dart';
import 'package:timnew_reader/presentations/components/ScreenScaffold.dart';

class BookInfoScreen extends StatelessWidget with RenderAsyncSnapshot<BookInfo> {
  final BookInfoRequest request;

  BookInfoScreen(BookIndex bookIndex)
      : assert(bookIndex != null),
        request = BookInfoRequest(bookIndex),
        super();

  static MaterialPageRoute buildRoute(BookIndex bookIndex) => MaterialPageRoute(
        settings: RouteSettings(name: "BookInfo", arguments: bookIndex),
        builder: (_) => BookInfoScreen(bookIndex),
      );

  @override
  Widget build(BuildContext context) => ScreenScaffold(
        title: request.bookName,
        body: buildStream(request.valueStream),
      );

  @override
  Widget buildData(BuildContext context, BookInfo bookInfo) {
    return _BookInfoView(bookInfo);
  }
}

class _BookInfoView extends StatelessWidget {
  final BookInfo bookInfo;

  _BookInfoView(this.bookInfo);

  Iterable<Widget> _buildItems(BuildContext context) sync* {
    if (bookInfo.hasAuthor) {
      yield ListTile(
        key: Key('author'),
        leading: Icon(Icons.person),
        title: Text('作者： ${bookInfo.author}'),
      );
    }

    if (bookInfo.hasGenre) {
      yield ListTile(
        key: Key('genre'),
        leading: Icon(Icons.category),
        title: Text('类型： ${bookInfo.genre}'),
      );
    }

    if (bookInfo.hasCompleteness) {
      yield ListTile(
        key: Key('completeness'),
        leading: Icon(Icons.more),
        title: Text('状态： ${bookInfo.completeness}'),
      );
    }

    if (bookInfo.hasLastUpdated) {
      yield ListTile(
        key: Key('lastUpdated'),
        leading: Icon(Icons.access_time),
        title: Text('最近更新时间： ${bookInfo.lastUpdated}'),
      );
    }

    if (bookInfo.hasLength) {
      yield ListTile(
        key: Key('length'),
        leading: Icon(Icons.translate),
        title: Text('总字数： ${bookInfo.lastUpdated}'),
      );
    }
  }

  @override
  Widget build(BuildContext context) => ListView(
        children: _buildItems(context).toList(growable: false),
      );
}
