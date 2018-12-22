import 'package:flutter/material.dart';
import 'package:reader/presentations/ReaderApp.dart';
import 'package:reader/repositories/settings/BookIndexRepository.dart';

void main() async {
  await BookIndexRepository.init();
  runApp(ReaderApp());
}
