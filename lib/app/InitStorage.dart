import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:timnew_reader/arch/ValueSource.dart';
import 'package:timnew_reader/repositories/PersistentStorage.dart';

class InitStorage extends ValueSource<PersistentStorage> {
  @override
  FutureOr<PersistentStorage> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    return PersistentStorage(prefs);
  }
}
