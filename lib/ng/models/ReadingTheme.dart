import 'package:flutter/material.dart';

class ReadingTheme {

  final bool isNightMode;

  final Color chapterViewTextColor;

  final Color chapterViewBackgroundColor;

  ReadingTheme(
      {this.isNightMode, this.chapterViewTextColor, this.chapterViewBackgroundColor});

  static final ReadingTheme defaultTheme = ReadingTheme(
      isNightMode: false,
      chapterViewTextColor: Colors.black,
      chapterViewBackgroundColor: const Color.fromARGB(255, 210, 180, 140));

  static final ReadingTheme darkTheme = ReadingTheme(
      isNightMode: true,
      chapterViewTextColor: Colors.white24,
      chapterViewBackgroundColor: Colors.black
  );
}
