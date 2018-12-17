import 'package:flutter/material.dart';
import 'package:reader/viewModels/ReadingTheme.dart';

typedef void GestureCallback(BuildContext context);

class ScreenScaffold extends StatelessWidget {
  final ReadingTheme readingTheme;
  final Widget floatingActionButton;
  final String title;
  final Widget titleWidget;
  final Iterable<Widget> appBarActions;
  final Widget body;
  final GestureCallback onDoubleTap;

  ScreenScaffold({
    this.readingTheme,
    this.title,
    this.titleWidget,
    this.appBarActions,
    this.body,
    this.floatingActionButton,
    this.onDoubleTap
  });

  @override
  Widget build(BuildContext context) => Scaffold(
      key: Key('ScreenScaffold'),
      backgroundColor: _renderBackground(),
      appBar: _renderAppBar(context),
      floatingActionButton: floatingActionButton,
      body: _renderBody(context));

  Color _renderBackground() =>
      readingTheme?.backgroundColor;

  Widget _renderAppBar(BuildContext context) {
    final renderedTitle = _renderTitle(context);

    if (renderedTitle == null) {
      return null;
    }

    return AppBar(
        title: renderedTitle,
        actions: _renderAppBarActions(context)
    );
  }

  Widget _renderTitle(BuildContext context) {
    return titleWidget ?? Text(title);
  }

  _renderAppBarActions(BuildContext context) {
    if (appBarActions != null) {
      return appBarActions.toList(growable: false);
    } else {
      return null;
    }
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
      final textStyle = TextStyle(color: readingTheme.textColor);
      return DefaultTextStyle.merge(
          style: textStyle,
          child: IconTheme.merge(
            data: IconThemeData(
                size: textStyle.fontSize, color: readingTheme.textColor),
            child: inner,
          )
      );
    } else {
      return inner;
    }
  }

  Widget _renderBodyPadding() =>
      Padding(padding: const EdgeInsets.all(8), child: body);
}
