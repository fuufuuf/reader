import 'package:built_value/built_value.dart';
import 'package:flutter/painting.dart';

part 'ReadingThemeData.g.dart';

abstract class ReadingThemeData implements Built<ReadingThemeData, ReadingThemeDataBuilder> {
  ReadingThemeData._();

  factory ReadingThemeData({
    Color textColor,
    Color backgroundColor,
    double fontScaleFactor,
    Color popUpTextColor,
    Color popUpBackgroundColor,
  }) =>
      _$ReadingThemeData((b) => b
        ..textColor = textColor
        ..backgroundColor = backgroundColor
        ..fontScaleFactor = fontScaleFactor
        ..popUpTextColor = popUpTextColor
        ..popUpBackgroundColor = popUpBackgroundColor);

  Color get textColor;

  Color get backgroundColor;

  double get fontScaleFactor;

  Color get popUpBackgroundColor;

  Color get popUpTextColor;
}
