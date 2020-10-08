import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timnew_reader/arch/Loader.dart';
import 'package:timnew_reader/repositories/PersistentStorage.dart';

class AppInitializer extends Loader<PersistentStorage> {
  AppInitializer({Key key, Widget child}) : super(key: key, child: child);

  @override
  Future<PersistentStorage> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    return PersistentStorage(prefs);
  }
}
