import 'package:flutter/material.dart';

class ReadingTheme {
  final Color textColor;

  final Color backgroundColor;

  final Color popUpMenuBackground;

  final Color popUpMenuTextColor;

  ReadingTheme(
      {this.textColor, this.backgroundColor, this.popUpMenuTextColor, this.popUpMenuBackground});

  static final ReadingTheme dayTheme = ReadingTheme(
      textColor: Colors.black,
      backgroundColor: const Color.fromARGB(255, 210, 180, 140),
      popUpMenuBackground: Color.fromARGB(80, 0, 0, 0),
      popUpMenuTextColor: Colors.white70
  );

  static final ReadingTheme nightTheme = ReadingTheme(
    textColor: Colors.white24,
    backgroundColor: Colors.black,
    popUpMenuBackground: Color.fromARGB(80, 0, 0, 0),
    popUpMenuTextColor: Colors.white24,
  );
}
