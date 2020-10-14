import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:timnew_reader/features/Theme/ReadingSettings.dart';

extension SharedPreferencesThemeExtension on SharedPreferences {
  static const appThemeKey = "reading_settings";

  ReadingSettings loadReadingSettings() {
    final entryJson = getString(appThemeKey);

    if (entryJson == null) return ReadingSettings();

    try {
      final entryData = jsonDecode(entryJson);

      final loaded = ReadingSettings.fromJson(entryData);

      return loaded;
    } catch (ex) {
      return ReadingSettings();
    }
  }

  Future<bool> saveReadingSettings(ReadingSettings settings) async {
    final entryData = settings.toJson();
    final entryJson = jsonEncode(entryData);

    return await setString(appThemeKey, entryJson);
  }
}
