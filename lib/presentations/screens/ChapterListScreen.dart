import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/events/EventBus.dart';
import 'package:reader/events/OpenUrlEvent.dart';
import 'package:reader/models/TableOfContents.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';

class ChapterListScreen extends StatelessWidget {
  final TableOfContents menu;

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
          EventBus.post(OpenUrlEvent(index.url));
        },
      );
}
