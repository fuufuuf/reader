import 'package:flutter/material.dart';

class ScreenScaffold extends StatelessWidget {
  final Color backgroundColor;
  final AppBar appBar;
  final Widget body;

  ScreenScaffold({this.backgroundColor, this.appBar, this.body});

  @override
  Widget build(BuildContext context) => Scaffold(
      key: Key('ScreenScaffold'),
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: Padding(padding: const EdgeInsets.all(8), child: body));
}
