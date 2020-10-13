import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/services.dart';

import 'ReadingThemeData.dart';

part 'AppTheme.freezed.dart';

@freezed
abstract class AppTheme with _$AppTheme {
  factory AppTheme({
    @required Brightness brightness,
    @required Duration transitionDuration,
    @required ReadingThemeData readingThemeData,
  }) = _AppTheme;
}
