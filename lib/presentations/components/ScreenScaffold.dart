import 'package:flutter/material.dart';

class ScreenScaffold extends StatelessWidget {
  final Widget floatingActionButton;
  final String title;
  final Widget titleWidget;
  final Widget appBarBottom;
  final List<Widget> appBarActions;
  final Widget body;

  ScreenScaffold({
    this.title,
    this.titleWidget,
    this.appBarBottom,
    this.appBarActions,
    this.body,
    this.floatingActionButton,
  })  : assert(title != null || titleWidget != null),
        assert(body != null);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: titleWidget ?? Text(title),
          actions: appBarActions,
          bottom: appBarBottom,
        ),
        floatingActionButton: floatingActionButton,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: body,
        ),
      );
}
