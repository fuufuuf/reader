import 'package:flutter/material.dart';
import 'package:reader/repositories/settings/ThemeRepository.dart';

class ReadingTheme {

  final Color textColor;
  final Color backgroundColor;
  final double fontSize;
  final Color popUpBackgroundColor;
  final Color popUpTextColor;

  final TextStyle readingTextStyle;
  final TextStyle statusBarTextStyle;
  final IconThemeData statusBarIconStyle;
  final TextStyle popUpMenuTextStyle;
  final IconThemeData popUpMenuIconStyle;

  ReadingTheme({
    this.textColor,
    this.backgroundColor,
    this.fontSize,
    this.popUpTextColor,
    this.popUpBackgroundColor
  })
      :
        readingTextStyle = TextStyle(color: textColor, fontSize: fontSize),
        statusBarTextStyle = TextStyle(color: textColor),
        statusBarIconStyle = IconThemeData(color: textColor),
        popUpMenuTextStyle = TextStyle(color: popUpTextColor),
        popUpMenuIconStyle = IconThemeData(color: popUpTextColor);

  static ReadingTheme loadDayTheme() =>
      ThemeRepository.fetchTheme(
          ThemeRepository.dayTheme);

  static ReadingTheme nightTheme() =>
      ThemeRepository.fetchTheme(
          ThemeRepository.nightTheme);
}
