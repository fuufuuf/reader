import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/features/Theme/AppTheme.dart';
import 'package:timnew_reader/features/Theme/ApplyTextColor.dart';

import 'BatteryInfo.dart';
import 'Clock.dart';

class SimpleStatusBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SimpleStatusBarState();
}

class _SimpleStatusBarState extends State<SimpleStatusBar> {
  @override
  Widget build(BuildContext context) => ApplyTextColor(
        textColor: context.watch<AppTheme>().contentForegroundColor,
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
