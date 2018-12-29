import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/models/BookIndex.dart';
import 'package:reader/models/ChapterList.dart';
import 'package:reader/models/ChapterRef.dart';
import 'package:reader/presentations/ReaderApp.AppRouter.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';
import 'package:reader/presentations/wrappers/ContentLoader.dart';

class ChapterListScreen extends StatelessWidget {
  final String bookId;

  ChapterListScreen({Key key, this.bookId}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookIndex bookIndex = BookIndex.load(bookId);

    return ScreenScaffold(
      title: bookIndex.bookName,
        appBarActions: <Widget>[
          IconButton(icon: Icon(Icons.info_outline), onPressed: () {
            AppRouter.openBookInfo(context, bookIndex.bookId);
          })
        ],
      body: ContentLoader<ChapterList>(
          future: bookIndex.fetchChapterList(),
          render: (BuildContext context, ChapterList chapterList) =>
                ChapterListView(bookIndex: bookIndex, chapterList: chapterList)
        ),
      );
  }
}

class ChapterListView extends StatelessWidget {
  final BookIndex bookIndex;
  final ChapterList chapterList;

  ChapterListView({@required this.bookIndex, @required this.chapterList});

  @override
  Widget build(BuildContext context) =>
      ListView.builder(
          itemBuilder: (context, index) =>
              _renderChapterIndex(context, chapterList.chapters[index]),
          itemCount: chapterList.chapters.length
      );

  Widget _renderChapterIndex(BuildContext context, ChapterRef index) =>
      ListTile(
        leading: Icon(Icons.bookmark_border),
        title: Text(index.title),
        onTap: () async {
          await AppRouter.openBookReader(context, bookIndex.bookId, index.url);
        },
      );
}
