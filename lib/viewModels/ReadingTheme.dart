import 'package:flutter/material.dart';

class ReadingTheme {
  final String name;

  final bool isNightMode;

  final Color textColor;

  final Color backgroundColor;

  ReadingTheme(
      {this.name, this.isNightMode, this.textColor, this.backgroundColor});

  static final ReadingTheme defaultTheme = ReadingTheme(
      name: '阅读模式',
      isNightMode: false,
      textColor: Colors.black,
      backgroundColor: const Color.fromARGB(255, 210, 180, 140));

  static final ReadingTheme darkTheme = ReadingTheme(
      name: '夜晚模式',
      isNightMode: true,
      textColor: Colors.white24,
      backgroundColor: Colors.black
  );
}
