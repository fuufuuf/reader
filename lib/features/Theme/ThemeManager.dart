import 'package:flutter/material.dart';
import 'package:timnew_reader/repositories/settings/ThemeRepository.dart';

import 'AppTheme.dart';

class ThemeManager extends ValueNotifier<AppTheme> {
  ThemeManager(AppTheme value) : super(value);

  void invertBrightness() {
    final newBrightness = value.brightness == Brightness.light ? Brightness.dark : Brightness.light;
    final newThemeName = newBrightness == Brightness.light ? ThemeRepository.dayTheme : ThemeRepository.nightTheme;
    final newReadingThemeData = ThemeRepository.fetchTheme(newThemeName);

    value = AppTheme(brightness: newBrightness, readingThemeData: newReadingThemeData);
  }

  Future updateTextScale(double newScaleFactor) async {
    value = value.putAppThemeData((b) => b.fontScaleFactor = newScaleFactor);

    await ThemeRepository.saveFontScaleFactor(newScaleFactor);
  }
}
