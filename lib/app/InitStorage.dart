import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timnew_reader/arch/Initializer.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';
import 'package:timnew_reader/repositories/PersistentStorage.dart';

class AppInitializer extends Initializer<PersistentStorage> {
  @override
  Future<PersistentStorage> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    return PersistentStorage(prefs);
  }

  Widget buildWaiting(BuildContext context) => DefaultRenders.buildWaiting(context);

  Widget buildError(BuildContext context, Object error) => DefaultRenders.buildError(context, error);
}
