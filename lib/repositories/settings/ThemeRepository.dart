import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timnew_reader/features/Theme/ReadingThemeData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  static SharedPreferences _preferences;

  static const _textColorKey = 'reading.textColor';
  static const _backgroundColorKey = 'reading.backgroundColor';
  static const _fontScaleFactorKey = 'theme._.reading.scaleFactor';
  static const _popUpTextColorKey = 'popUp.textColor';
  static const _popUpBackgroundColorKey = 'popUp.backgroundColor';

  static const dayTheme = 'day';
  static const nightTheme = 'night';

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();

    await _initTheme();
  }

  static Future<void> _initTheme() async {
    // if (_preferences.get(_themeKey(dayTheme, _textColorKey)) == null) {
    await saveTheme(
        dayTheme,
        ReadingThemeData(
            textColor: Colors.black,
            backgroundColor: const Color.fromARGB(255, 210, 180, 140),
            fontScaleFactor: 1.0,
            popUpBackgroundColor: Color.fromARGB(80, 0, 0, 0),
            popUpTextColor: Colors.white70));

    await saveTheme(
        nightTheme,
        ReadingThemeData(
          textColor: Colors.white24,
          backgroundColor: Colors.black,
          fontScaleFactor: 1.0,
          popUpBackgroundColor: Color.fromARGB(80, 0, 0, 0),
          popUpTextColor: Colors.white24,
        ));
    // }
  }

  static ReadingThemeData getPalette(Brightness brightness) {
    if (brightness == Brightness.light)
      return ReadingThemeData(
          textColor: Colors.black87,
          backgroundColor: const Color.fromARGB(255, 210, 180, 140),
          fontScaleFactor: 1.0,
          popUpBackgroundColor: Color.fromARGB(80, 0, 0, 0),
          popUpTextColor: Colors.white70);
    else
      return ReadingThemeData(
        textColor: Colors.white24,
        backgroundColor: Colors.black,
        fontScaleFactor: 1.0,
        popUpBackgroundColor: Color.fromARGB(80, 0, 0, 0),
        popUpTextColor: Colors.white24,
      );
  }

  static ReadingThemeData fetchTheme(String themeId) {
    return ReadingThemeData(
      textColor: _loadColor(themeId, _textColorKey),
      backgroundColor: _loadColor(themeId, _backgroundColorKey),
      fontScaleFactor: _preferences.getDouble(_fontScaleFactorKey) ?? 1.0,
      popUpTextColor: _loadColor(themeId, _popUpTextColorKey),
      popUpBackgroundColor: _loadColor(themeId, _popUpBackgroundColorKey),
    );
  }

  static Future<void> saveTheme(String themeId, ReadingThemeData theme) async {
    await _saveColor(themeId, _textColorKey, theme.textColor);
    await _saveColor(themeId, _backgroundColorKey, theme.backgroundColor);
    await saveFontScaleFactor(theme.fontScaleFactor);
    await _saveColor(themeId, _popUpTextColorKey, theme.popUpTextColor);
    await _saveColor(themeId, _popUpBackgroundColorKey, theme.popUpBackgroundColor);
  }

  static Future<void> saveFontScaleFactor(double scaleFactor) async {
    await _preferences.setDouble(_fontScaleFactorKey, scaleFactor);
  }

  static String _themeKey(String themeId, String field) => "theme.$themeId.$field";

  static Color _loadColor(String themeId, String field) => Color(_preferences.getInt(_themeKey(themeId, field)));

  static Future<bool> _saveColor(String themeId, String field, Color color) =>
      _preferences.setInt(_themeKey(themeId, field), color.value);
}
