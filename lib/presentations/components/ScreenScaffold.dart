import 'package:flutter/material.dart';

typedef void GestureCallback(BuildContext context);

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
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _renderAppBar(context),
        floatingActionButton: floatingActionButton,
        body: _renderBody(context),
      );

  Widget _renderAppBar(BuildContext context) => AppBar(
        title: _renderTitle(context),
        actions: appBarActions,
        bottom: appBarBottom,
      );

  Widget _renderTitle(BuildContext context) {
    return titleWidget ?? Text(title);
  }

  Widget _renderBody(BuildContext context) => Padding(padding: const EdgeInsets.all(8), child: body);
}
