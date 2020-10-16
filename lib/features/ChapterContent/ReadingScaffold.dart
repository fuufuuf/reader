import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';
import 'package:timnew_reader/features/ChapterContent/SimpleStatusBar.dart';
import 'package:timnew_reader/features/Theme/AppTheme.dart';

typedef void GestureCallback(BuildContext context);

class ReadingScaffold extends StatelessWidget with BuilderWitBuilderInLocalContext {
  final Widget content;
  final TransitionBuilder builder;

  ReadingScaffold({this.content, this.builder});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();

    return Scaffold(
      key: Key('ReaderScaffold'),
      body: AnimatedContainer(
        color: appTheme.palette.contentBackgroundColor,
        duration: appTheme.defaultTransitionDuration,
        child: buildWithBuilder(
          builder,
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                SimpleStatusBar(),
                Expanded(child: content),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
