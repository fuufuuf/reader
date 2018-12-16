import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/models/ChapterList.dart';
import 'package:reader/models/ChapterRef.dart';
import 'package:reader/presentations/ReaderApp.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';

class ChapterListScreen extends StatelessWidget {
  final ChapterList chapterList;

  ChapterListScreen({@required this.chapterList});

  @override
  Widget build(BuildContext context) =>
      ScreenScaffold(
          appBar: AppBar(
            title: Text(chapterList.title),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.info_outline), onPressed: () {

              })
            ],
          ),
          body: ListView.builder(
              itemBuilder: (context, index) =>
                  _renderChapterIndex(context, chapterList.chapters[index]),
              itemCount: chapterList.chapters.length
          )
      );

  Widget _renderChapterIndex(BuildContext context, ChapterRef index) =>
      ListTile(
        leading: Icon(Icons.bookmark_border),
        title: Text(index.title),
        onTap: () {
          ReaderApp.openUrl(context, index.url);
        },
      );
}
