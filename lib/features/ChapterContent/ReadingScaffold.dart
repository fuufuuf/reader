import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/features/ChapterContent/SimpleStatusBar.dart';
import 'package:timnew_reader/features/Theme/AppTheme.dart';

import 'ReadingTheme.dart';

typedef void GestureCallback(BuildContext context);
typedef void GestureCallbackWithPos(BuildContext context, Offset position);

class ReadingScaffold extends StatelessWidget {
  final Widget content;
  final GestureCallback onDoubleTap;

  ReadingScaffold({this.content, this.onDoubleTap});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();

    return Scaffold(
        key: Key('ReaderScaffold'),
        body: AnimatedContainer(
          color: appTheme.readingThemeData.backgroundColor,
          duration: appTheme.transitionDuration,
          child: GestureDetector(
            onDoubleTap: () => onDoubleTap(context),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  SimpleStatusBar(),
                  Expanded(child: ReadingTheme(child: content)),
                ],
              ),
            ),
          ),
        ));
  }
}
