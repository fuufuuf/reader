import 'dart:async';

import 'package:battery/battery.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:timnew_reader/widgets/ReaderIcons.dart';

class BatteryInfo extends StatefulWidget {
  final Duration updateInterval;

  const BatteryInfo({Key key, this.updateInterval: const Duration(seconds: 10)}) : super(key: key);

  @override
  _BatteryInfoState createState() => _BatteryInfoState();
}

class _BatteryInfoState extends State<BatteryInfo> {
  final batteryService = Battery();

  BatteryState state;
  int level;

  @override
  void initState() {
    super.initState();

    batteryService.onBatteryStateChanged.listen(_onBatteryStateChanged);

    Timer.periodic(widget.updateInterval, _refreshBatteryLevel);
  }

  void _refreshBatteryLevel([Timer timer]) async {
    try {
      final newLevel = await batteryService.batteryLevel;

      setState(() {
        level = newLevel;
      });
    } on PlatformException catch (_) {
      // ignore error
    }
  }

  void _onBatteryStateChanged(BatteryState newState) {
    setState(() {
      state = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.baseline, children: <Widget>[
      Text(level == null ? "未知" : "$level%"),
      Padding(
        padding: const EdgeInsets.only(left: 4, right: 8),
        child: Icon(_batteryIcon(), size: 16),
      ),
    ]);
  }

  IconData _batteryIcon() {
    if (state == BatteryState.charging) return ReaderIcons.battery_chagring;

    if (level == null) return ReaderIcons.battery_0;

//    0     25    50     75         100
//    0-10 11-36 37-62 63- 89 90 - 100
//    10    25   25     26      10
    if (level >= 90) return ReaderIcons.battery_100;

    if (level >= 63) return ReaderIcons.battery_75;

    if (level >= 37) return ReaderIcons.battery_50;

    if (level >= 11) return ReaderIcons.battery_25;

    return ReaderIcons.battery_0;
  }
}
