import 'package:built_value/built_value.dart';
import 'package:flutter/services.dart';

import 'ReadingThemeData.dart';

part 'AppTheme.g.dart';

abstract class AppTheme implements Built<AppTheme, AppThemeBuilder> {
  AppTheme._();

  factory AppTheme({Brightness brightness, ReadingThemeData readingThemeData}) => _$AppTheme((b) => b
    ..readingThemeData.replace(readingThemeData)
    ..brightness = brightness);

  ReadingThemeData get readingThemeData;

  Brightness get brightness;

  Duration get transitionDuration => Duration(milliseconds: 500);

  AppTheme putAppThemeData(Function(ReadingThemeDataBuilder) builder) => rebuild((b) => builder(b.readingThemeData));
}
