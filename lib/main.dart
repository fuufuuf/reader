import 'package:flutter/material.dart';
import 'package:timnew_reader/presentations/ReaderApp.dart';
import 'package:timnew_reader/repositories/settings/ThemeRepository.dart';
import 'package:timnew_reader/repositories/settings/BookIndexRepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeRepository.init();
  await BookIndexRepository.init();
  runApp(ReaderApp());
}
