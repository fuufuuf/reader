import 'dart:async';

import 'package:flutter/widgets.dart';

class ReadingStatusBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReadingStatusBarState();
}

class _ReadingStatusBarState extends State<ReadingStatusBar> {
  DateTime now;

  _ReadingStatusBarState() {
    now = DateTime.now();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      now = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) => Row(
          key: Key('ReadingStatusBar'),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _Clock(now),
          ]);
}

class _Clock extends StatelessWidget {
  final DateTime now;

  const _Clock(this.now);

  static String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String get timeString => "${_twoDigits(now.hour)}:${_twoDigits(now.minute)}";

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
      child: Text(timeString));
}
