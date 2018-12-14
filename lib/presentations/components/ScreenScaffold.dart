import 'package:flutter/material.dart';
import 'package:reader/models/ReadingTheme.dart';

typedef void GestureCallback(BuildContext context);

class ScreenScaffold extends StatelessWidget {
  final ReadingTheme readingTheme;
  final AppBar appBar;
  final String title;
  final Widget body;
  final GestureCallback onDoubleTap;

  ScreenScaffold({
    this.readingTheme,
    this.appBar,
    this.title,
    this.body,
    this.onDoubleTap
  });

  @override
  Widget build(BuildContext context) => Scaffold(
      key: Key('ScreenScaffold'),
      backgroundColor: _renderBackground(),
      appBar: _renderAppBar(),
      body: _renderBody(context));

  Color _renderBackground() =>
      readingTheme?.backgroundColor;

  Widget _renderAppBar() {
    if (appBar != null) {
      return appBar;
    }

    if (title != null) {
      return AppBar(title: Text(title));
    }

    return null;
  }

  Widget _renderBody(BuildContext context) {
    return _renderGestureDetector(
        context, _renderTheme(context, _renderBodyPadding()));
  }

  bool get hasGestureDetectorCallback =>
      onDoubleTap != null;

  Widget _renderGestureDetector(BuildContext context, Widget inner) {
    if (hasGestureDetectorCallback) {
      return GestureDetector(
        onDoubleTap: onDoubleTap == null ? null : () {
          onDoubleTap(context);
        },
        child: inner,
      );
    } else {
      return inner;
    }
  }

  Widget _renderTheme(BuildContext context, Widget inner) {
    if (readingTheme != null) {
      return DefaultTextStyle.merge(
          style: TextStyle(color: readingTheme.textColor),
          child: inner
      );
    } else {
      return inner;
    }
  }

  Widget _renderBodyPadding() =>
      Padding(padding: const EdgeInsets.all(8), child: body);
}
