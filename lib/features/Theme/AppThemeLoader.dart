import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:timnew_reader/arch/Loader.dart';
import 'package:timnew_reader/repositories/settings/ThemeRepository.dart';

import 'AppTheme.dart';
import 'ThemeManager.dart';

class AppThemeLoader extends Loader<ThemeManager> {
  AppThemeLoader({Key key, Widget child}) : super(key: key, child: child);

  @override
  Future<ThemeManager> initialize() async {
    await ThemeRepository.init();

    final readingThemeData = ThemeRepository.getPalette(Brightness.light);

    final appTheme = AppTheme(brightness: Brightness.light, readingThemeData: readingThemeData);
    return ThemeManager(appTheme);
  }
}
