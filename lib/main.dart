import 'package:flutter/material.dart';
import 'package:reader/presentations/ReaderApp.dart';
import 'package:reader/repositories/settings/ThemeRepository.dart';
import 'package:reader/repositories/settings/BookIndexRepository.dart';

void main() async {
  await ThemeRepository.init();
  await BookIndexRepository.init();
  runApp(ReaderApp());
}
