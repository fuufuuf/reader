import 'package:flutter/painting.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ReadingThemeData.freezed.dart';

@freezed
abstract class ReadingThemeData with _$ReadingThemeData {
  factory ReadingThemeData({
    @required Color textColor,
    @required Color backgroundColor,
    @Default(1.0) double fontScaleFactor,
    @required Color popUpTextColor,
    @required Color popUpBackgroundColor,
  }) = _ReadingThemeData;
}
