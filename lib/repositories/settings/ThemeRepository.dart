import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timnew_reader/models/ReadingTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  static SharedPreferences _preferences;

  static const _textColorKey = 'reading.textColor';
  static const _backgroundColorKey = 'reading.backgroundColor';
  static const _fontSizeKey = 'theme._.reading.fontSize';
  static const _popUpTextColorKey = 'popUp.textColor';
  static const _popUpBackgroundColorKey = 'popUp.backgroundColor';

  static const dayTheme = 'day';
  static const nightTheme = 'night';

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();

    await _initTheme();
  }

  static Future<void> _initTheme() async {
    if (_preferences.get(_themeKey(dayTheme, _textColorKey)) == null) {
      await saveTheme(
          dayTheme,
          ReadingTheme(
              textColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 210, 180, 140),
              popUpBackgroundColor: Color.fromARGB(80, 0, 0, 0),
              popUpTextColor: Colors.white70));

      await saveTheme(
          nightTheme,
          ReadingTheme(
            textColor: Colors.white24,
            backgroundColor: Colors.black,
            popUpBackgroundColor: Color.fromARGB(80, 0, 0, 0),
            popUpTextColor: Colors.white24,
          ));
    }
  }

  static ReadingTheme fetchTheme(String themeId) {
    return ReadingTheme(
      textColor: _loadColor(themeId, _textColorKey),
      backgroundColor: _loadColor(themeId, _backgroundColorKey),
      fontSize: _preferences.getDouble(_fontSizeKey),
      popUpTextColor: _loadColor(themeId, _popUpTextColorKey),
      popUpBackgroundColor: _loadColor(themeId, _popUpBackgroundColorKey),
    );
  }

  static Future<void> saveTheme(String themeId, ReadingTheme theme) async {
    await _saveColor(themeId, _textColorKey, theme.textColor);
    await _saveColor(themeId, _backgroundColorKey, theme.backgroundColor);
    await saveFontSize(theme.fontSize);
    await _saveColor(themeId, _popUpTextColorKey, theme.popUpTextColor);
    await _saveColor(themeId, _popUpBackgroundColorKey, theme.popUpBackgroundColor);
  }

  static Future<void> saveFontSize(double fontSize) async {
    await _preferences.setDouble(_fontSizeKey, fontSize);
  }

  static String _themeKey(String themeId, String field) => "theme.$themeId.$field";

  static Color _loadColor(String themeId, String field) => Color(_preferences.getInt(_themeKey(themeId, field)));

  static Future<bool> _saveColor(String themeId, String field, Color color) =>
      _preferences.setInt(_themeKey(themeId, field), color.value);
}
