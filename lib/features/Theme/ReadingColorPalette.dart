import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ReadingColorPalette.freezed.dart';

@freezed
abstract class ReadingColorPalette with _$ReadingColorPalette {
  factory ReadingColorPalette({
    @required Brightness brightness,
    @required BuiltList<Color> contentForegroundColors,
    @required int contentForegroundColorDefaultIndex,
    @required Color contentBackgroundColor,
    @required Color controlPanelForegroundColor,
    @required Color controlPanelBackgroundColor,
  }) = _ReadingColorPalette;

  factory ReadingColorPalette.light() => ReadingColorPalette(
        brightness: Brightness.light,
        contentForegroundColors: BuiltList.of([
          Colors.black,
          Colors.black87,
          Colors.black54,
          Colors.black45,
          Colors.black38,
          Colors.black26,
          Colors.black12,
        ]),
        contentForegroundColorDefaultIndex: 1,
        contentBackgroundColor: const Color.fromARGB(255, 210, 180, 140),
        controlPanelForegroundColor: Colors.white70,
        controlPanelBackgroundColor: const Color.fromARGB(80, 0, 0, 0),
      );

  factory ReadingColorPalette.dark() => ReadingColorPalette(
        brightness: Brightness.dark,
        contentForegroundColors: BuiltList.of([
          Colors.white38,
          Colors.white30,
          Colors.white24,
          Colors.white12,
          Colors.white10,
        ]),
        contentForegroundColorDefaultIndex: 2,
        contentBackgroundColor: Colors.black,
        controlPanelForegroundColor: Colors.white24,
        controlPanelBackgroundColor: const Color.fromARGB(80, 0, 0, 0),
      );

  factory ReadingColorPalette.fromBrightness(Brightness brightness) {
    if (brightness == Brightness.light)
      return ReadingColorPalette.light();
    else
      return ReadingColorPalette.dark();
  }
}

extension BrightnessInvertExtension on Brightness {
  Brightness invert() => this == Brightness.light ? Brightness.dark : Brightness.light;
}
