import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timnew_reader/app/routing/AppRouter.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/presentations/components/ScreenScaffold.dart';
import 'package:timnew_reader/presentations/wrappers/ContentLoader.dart';

class ChapterListScreen extends StatelessWidget {
  final BookIndex bookIndex;

  ChapterListScreen(this.bookIndex);

  @override
  Widget build(BuildContext context) => ScreenScaffold(
        title: bookIndex.bookName,
        appBarActions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => AppRouter.of(context).openBookInfo(bookIndex),
          ),
        ],
        body: ContentLoader<ChapterList>(
            future: bookIndex.fetchChapterList(),
            render: (BuildContext context, ChapterList chapterList) =>
                ChapterListView(bookIndex: bookIndex, chapterList: chapterList)),
      );

  static MaterialPageRoute buildRoute(BookIndex bookIndex) => MaterialPageRoute(
        settings: RouteSettings(name: "ChapterList", arguments: bookIndex),
        builder: (_) => ChapterListScreen(bookIndex),
      );
}

class ChapterListView extends StatelessWidget {
  final BookIndex bookIndex;
  final ChapterList chapterList;

  ChapterListView({@required this.bookIndex, @required this.chapterList});

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemBuilder: (context, index) => _renderChapterIndex(context, chapterList.chapters[index]),
      itemCount: chapterList.chapters.length);

  Widget _renderChapterIndex(BuildContext context, ChapterRef index) => ListTile(
        leading: Icon(Icons.bookmark_border),
        title: Text(index.title),
        onTap: () async {
          await AppRouter.of(context).openReader(bookIndex, index);
        },
      );
}
