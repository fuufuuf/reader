import 'package:flutter/material.dart';

class ReadingTheme {
  static const defaultFontSize = 14.0;

  final Color textColor;

  final Color backgroundColor;

  final double fontSize;

  final Color popUpMenuBackground;

  final Color popUpMenuTextColor;

  final TextStyle readingTextStyle;
  final TextStyle statusBarTextStyle;
  final IconThemeData statusBarIconStyle;
  final TextStyle popUpMenuTextStyle;

  ReadingTheme(
      {this.textColor, this.backgroundColor, this.fontSize = defaultFontSize, this.popUpMenuTextColor, this.popUpMenuBackground})
      :
        readingTextStyle = TextStyle(color: textColor, fontSize: fontSize),
        statusBarTextStyle = TextStyle(color: textColor),
        statusBarIconStyle = IconThemeData(color: textColor),
        popUpMenuTextStyle = TextStyle(color: popUpMenuTextColor);

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
