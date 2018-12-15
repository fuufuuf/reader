import 'package:flutter/material.dart';

class ReadingTheme {

  final bool isNightMode;

  final Color textColor;

  final Color backgroundColor;

  ReadingTheme({this.isNightMode, this.textColor, this.backgroundColor});

  static final ReadingTheme defaultTheme = ReadingTheme(
      isNightMode: false,
      textColor: Colors.black,
      backgroundColor: const Color.fromARGB(255, 210, 180, 140));

  static final ReadingTheme darkTheme = ReadingTheme(
      isNightMode: true,
      textColor: Colors.white24,
      backgroundColor: Colors.black
  );
}
