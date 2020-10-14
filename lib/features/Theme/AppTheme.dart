import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/services.dart';
import 'package:timnew_reader/features/Theme/ReadingSettings.dart';

import 'ReadingColorPalette.dart';

part 'AppTheme.freezed.dart';

@freezed
abstract class AppTheme implements _$AppTheme {
  AppTheme._();

  factory AppTheme({
    @required ReadingColorPalette palette,
    @required ReadingSettings settings,
  }) = _AppTheme;

  factory AppTheme.fromSettings(ReadingSettings settings) =>
      AppTheme(palette: ReadingColorPalette.light(), settings: settings);

  Duration get defaultTransitionDuration => const Duration(microseconds: 800);

  Color get contentForegroundColor => palette.contentForegroundColors[contentForegroundColorIndex];

  int get contentForegroundColorIndex => palette.brightness == Brightness.light
      ? settings.lightContentForegroundColorIndex ?? palette.contentForegroundColorDefaultIndex
      : settings.darkContentForegroundColorIndex ?? palette.contentForegroundColorDefaultIndex;

  AppTheme putContentForegroundColorIndex(int newIndex) {
    final regulated = newIndex % palette.contentForegroundColors.length;

    if (palette.brightness == Brightness.light)
      return copyWith.settings(lightContentForegroundColorIndex: regulated);
    else
      return copyWith.settings(darkContentForegroundColorIndex: regulated);
  }

  AppTheme invertBrightness() {
    final newBrightness = palette.brightness.invert();
    final newPalette = ReadingColorPalette.fromBrightness(newBrightness);

    return copyWith(palette: newPalette);
  }
}
