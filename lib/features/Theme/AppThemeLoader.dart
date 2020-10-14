import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timnew_reader/arch/Loader.dart';

import 'AppThemeManager.dart';

class AppThemeLoader extends Loader<AppThemeManager> {
  AppThemeLoader({Key key, Widget child}) : super(key: key, child: child);

  @override
  Future<AppThemeManager> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    return AppThemeManager.fromSharedPreferences(prefs);
  }
}
