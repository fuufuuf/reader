import 'package:flutter/material.dart';
import 'package:reader/presentations/components/ThemeRender.dart';
import 'package:reader/presentations/screens/readingScreen/SimpleStatusBar.dart';
import 'package:reader/viewModels/ReadingTheme.dart';

typedef void GestureCallback(BuildContext context);
typedef void GestureCalbackWithPos(BuildContext context, Offset position);

class ReadingScaffold extends StatelessWidget {
  final ReadingTheme readingTheme;
  final Widget content;
  final GestureCallback onDoubleTap;
  final GestureCalbackWithPos onTapWithPos;

  ReadingScaffold(
      {this.readingTheme, this.content, this.onDoubleTap, this.onTapWithPos});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          key: Key('ReaderScaffold'),
          backgroundColor: _renderBackground(),
          body: _renderGestureDetector(context,
              child: _renderTheme(
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                          children: <Widget>[
                          SimpleStatusBar(),
                          Expanded(child: content)
                        ],
                      )
                  )
              )
          )
      );

  Color _renderBackground() => readingTheme?.backgroundColor;

  bool get hasGestureDetectorCallback => onDoubleTap != null;

  Widget _renderGestureDetector(BuildContext context, {Widget child}) {
    if (hasGestureDetectorCallback) {
      return GestureDetector(
        onDoubleTap: onDoubleTap == null
            ? null
            : () {
          onDoubleTap(context);
        },
        onTapUp: onTapWithPos == null
            ? null
            : (TapUpDetails tapDetails) {
          onTapWithPos(context, tapDetails.globalPosition);
        },
        child: child,
      );
    } else {
      return child;
    }
  }

  Widget _renderTheme({Widget child}) {
    if (readingTheme != null) {
      return ThemeRender(theme: readingTheme, child: child);
    } else {
      return child;
    }
  }
}
