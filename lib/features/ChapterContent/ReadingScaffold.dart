import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/features/ChapterContent/SimpleStatusBar.dart';
import 'package:timnew_reader/features/Theme/AppTheme.dart';

import 'ReadingTheme.dart';

typedef void GestureCallback(BuildContext context);

class ReadingScaffold extends StatelessWidget {
  final Widget content;
  final TransitionBuilder builder;

  ReadingScaffold({this.content, this.builder});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();

    return Scaffold(
        key: Key('ReaderScaffold'),
        body: AnimatedContainer(
          color: appTheme.readingThemeData.backgroundColor,
          duration: appTheme.transitionDuration,
          child: Builder(
            builder: (childContext) => builder(
              childContext,
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    SimpleStatusBar(),
                    Expanded(child: ReadingTheme(child: content)),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
