import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timnew_reader/arch/SIngletonRegistry.dart';
import 'package:timnew_reader/repositories/settings/SharedPreferencesThemeExtension.dart';

import 'AppTheme.dart';

class AppThemeManager extends ValueNotifier<AppTheme> {
  static AppThemeManager get instance => SingletonRegistry.get();

  static Future<AppThemeManager> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    return SingletonRegistry.register(AppThemeManager.fromSharedPreferences(prefs));
  }

  final SharedPreferences prefs;

  factory AppThemeManager.fromSharedPreferences(SharedPreferences prefs) {
    return AppThemeManager(prefs, AppTheme.fromSettings(prefs.loadReadingSettings()));
  }

  AppThemeManager(this.prefs, AppTheme value) : super(value);

  Future<AppTheme> updateAppTheme(AppTheme Function(AppTheme) updater) async {
    final newValue = updater(value);

    value = newValue;

    await prefs.saveReadingSettings(newValue.settings);

    return newValue;
  }
}
