import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timnew_reader/repositories/settings/SharedPreferencesThemeExtension.dart';

import 'AppTheme.dart';

class AppThemeManager extends ValueNotifier<AppTheme> {
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
