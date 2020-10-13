import 'package:flutter/material.dart';
import 'package:timnew_reader/repositories/settings/ThemeRepository.dart';

import 'AppTheme.dart';

class ThemeManager extends ValueNotifier<AppTheme> {
  ThemeManager(AppTheme value) : super(value);

  void invertBrightness() {
    final newBrightness = value.brightness == Brightness.light ? Brightness.dark : Brightness.light;
    final newReadingThemeData = ThemeRepository.getPalette(newBrightness);

    value = AppTheme(
      brightness: newBrightness,
      readingThemeData: newReadingThemeData,
      transitionDuration: Duration(microseconds: 800),
    );
  }

  Future updateTextScale(double newScaleFactor) async {
    value = value.copyWith.readingThemeData(fontScaleFactor: newScaleFactor);

    await ThemeRepository.saveFontScaleFactor(newScaleFactor);
  }
}
