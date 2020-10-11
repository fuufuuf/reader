import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timnew_reader/arch/Loader.dart';
import 'package:timnew_reader/repositories/PersistentStorage.dart';

class PersistentStorageInitializer extends Loader<PersistentStorage> {
  PersistentStorageInitializer({Key key, Widget child}) : super(key: key, child: child);

  @override
  Future<PersistentStorage> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    return PersistentStorage(prefs);
  }
}
