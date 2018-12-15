import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/models/ChapterList.dart';
import 'package:reader/models/ChapterRef.dart';
import 'package:reader/presentations/ReaderApp.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';

class ChapterListScreen extends StatelessWidget {
  final ChapterList menu;

  ChapterListScreen({@required this.menu});

  @override
  Widget build(BuildContext context) =>
      ScreenScaffold(
          title: menu.title,
          body: ListView.builder(
              itemBuilder: (context, index) =>
                  _renderChapterIndex(context, menu.chapters[index]),
              itemCount: menu.chapters.length
          )
      );

  Widget _renderChapterIndex(BuildContext context, ChapterRef index) =>
      ListTile(
        leading: const Icon(
          Icons.note,
          size: 32,
        ),
        title: Text(index.title),
        onTap: () {
          ReaderApp.openUrl(context, index.url);
        },
      );
}
