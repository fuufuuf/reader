import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timnew_reader/presentations/wrappers/ReadingThemeProvider.dart';

import 'BatteryInfo.dart';
import 'Clock.dart';

class SimpleStatusBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SimpleStatusBarState();
}

class _SimpleStatusBarState extends State<SimpleStatusBar> {
  @override
  Widget build(BuildContext context) => _ThemeRender(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Clock(),
              BatteryInfo(),
            ],
          ),
        ),
      );
}

class _ThemeRender extends StatelessWidget {
  final Widget child;

  _ThemeRender({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ReadingThemeProvider.of(context);
    return DefaultTextStyle.merge(
        style: theme.statusBarTextStyle,
        child: IconTheme.merge(
          data: theme.statusBarIconStyle,
          child: child,
        ));
  }
}
