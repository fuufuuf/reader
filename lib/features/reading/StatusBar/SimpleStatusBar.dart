import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timnew_reader/presentations/wrappers/ReadingThemeProvider.dart';

import 'BetteryInfo.dart';

class SimpleStatusBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SimpleStatusBarState();
}

class _SimpleStatusBarState extends State<SimpleStatusBar> {
  DateTime now;

  _SimpleStatusBarState() {
    _refreshTime();

    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      setState(_refreshTime);
    });
  }

  void _refreshTime() {
    now = DateTime.now();
  }

  @override
  Widget build(BuildContext context) => _ThemeRender(
          child:
              Row(key: Key('ReadingStatusBar'), mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        _Clock(now),
        BatteryInfo(),
      ]));
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

class _Clock extends StatelessWidget {
  final DateTime now;

  const _Clock(this.now);

  static String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String get timeString => "${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}";

  @override
  Widget build(BuildContext context) =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4), child: Text(timeString));
}
