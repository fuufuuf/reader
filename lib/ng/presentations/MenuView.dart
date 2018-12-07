import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/ng/events/EventBus.dart';
import 'package:reader/ng/events/OpenUrlEvent.dart';
import 'package:reader/ng/models/Menu.dart';
import 'package:reader/ng/models/ReadingTheme.dart';
import 'package:reader/ng/presentations/ReadingThemeProvider.dart';

class MenuView extends StatelessWidget {
  final Menu menu;

  MenuView({@required this.menu});

  @override
  Widget build(BuildContext context) =>
      _renderWithTheme(
          context, ReadingThemeProvider.fetchReadingTheme(context));

  Widget _renderWithTheme(BuildContext context, ReadingTheme theme) =>
      Scaffold(
          appBar: AppBar(
            title: Text(menu.title),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListView.builder(
              itemBuilder: (context, index) =>
                  _renderChapterIndex(context, menu.chapters[index]),
              itemCount: menu.chapters.length,
            ),
          )
      );

  Widget _renderChapterIndex(BuildContext context, ChapterIndex index) =>
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
