import 'dart:async';

import 'package:flutter/widgets.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), _refresh);
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  void _refresh(Timer _) {
    setState(() {});
  }

  static String _twoDigits(int n) => n.toString().padLeft(2, '0');

  String get timeString {
    final now = DateTime.now();

    return "${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}";
  }

  @override
  Widget build(BuildContext context) => Text(timeString);
}
