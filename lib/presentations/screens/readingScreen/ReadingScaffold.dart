import 'package:flutter/material.dart';
import 'package:reader/presentations/screens/readingScreen/SimpleStatusBar.dart';
import 'package:reader/presentations/wrappers/ReadingThemeProvider.dart';

typedef void GestureCallback(BuildContext context);
typedef void GestureCallbackWithPos(BuildContext context, Offset position);

class ReadingScaffold extends StatelessWidget {
  final Widget content;
  final GestureCallback onDoubleTap;
  final GestureCallbackWithPos onTapWithPos;

  ReadingScaffold({this.content, this.onDoubleTap, this.onTapWithPos});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          key: Key('ReaderScaffold'),
          backgroundColor: _renderBackground(context),
          body: _renderGestureDetector(context,
              child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                          children: <Widget>[
                          SimpleStatusBar(),
                          Expanded(child:
                          _renderTheme(context,
                              child: content
                          )
                          )
                        ],
                      )
                  )
          )
      );

  Color _renderBackground(BuildContext context) =>
      ReadingThemeProvider
          .of(context)
          .backgroundColor;

  Widget _renderTheme(BuildContext context, { Widget child }) =>
      DefaultTextStyle(
        style: ReadingThemeProvider
            .of(context)
            .readingTextStyle,
        child: child,
      );


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


}
