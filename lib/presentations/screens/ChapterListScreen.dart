import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/models/ChapterList.dart';
import 'package:reader/models/ChapterRef.dart';
import 'package:reader/presentations/ReaderApp.AppRouter.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';
import 'package:reader/presentations/wrappers/ContentOwner.dart';
import 'package:reader/repositories/settings/BookEntryRepository.dart';

class ChapterListScreen extends StatelessWidget {
  final String bookId;

  ChapterListScreen({Key key, this.bookId}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookEntry = BookEntryRepository.fetchEntry(bookId);

    return ScreenScaffold(
        title: bookEntry.bookName,
        appBarActions: <Widget>[
          IconButton(icon: Icon(Icons.info_outline), onPressed: () {
            AppRouter.openBookInfo(context, bookEntry);
          })
        ],
        body: ContentOwner<ChapterList>(
            controller: ContentController<ChapterList>(
                initialFuture: bookEntry.fetchChapterList()
            ),
            render: (BuildContext context, ChapterList chapterList) =>
                ChapterListView(bookEntry: bookEntry, chapterList: chapterList)
        ),
      );
  }
}

class ChapterListView extends StatelessWidget {
  final BookEntry bookEntry;
  final ChapterList chapterList;

  ChapterListView({@required this.bookEntry, @required this.chapterList});

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
          await AppRouter.openBookReader(context, bookEntry, index.url);
        },
      );
}
