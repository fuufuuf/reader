import 'package:flutter/material.dart';

class ScreenScaffold extends StatelessWidget {
  final Widget floatingActionButton;
  final Widget title;
  final List<Widget> appBarActions;
  final Widget body;

  ScreenScaffold({
    @required this.title,
    this.appBarActions,
    @required this.body,
    this.floatingActionButton,
  })  : assert(title != null),
        assert(body != null);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: title,
          actions: appBarActions,
        ),
        floatingActionButton: floatingActionButton,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: body,
        ),
      );
}
