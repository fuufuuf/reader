import 'package:freezed_annotation/freezed_annotation.dart';

part 'ReadingSettings.freezed.dart';

part 'ReadingSettings.g.dart';

@freezed
abstract class ReadingSettings with _$ReadingSettings {
  factory ReadingSettings.fromJson(Map<String, dynamic> json) => _$ReadingSettingsFromJson(json);

  factory ReadingSettings({
    @Default(1.0) double readingTextScaleFactor,
    @Default(1.4) double readingLineSpaceScaleFactor,
    @nullable int lightContentForegroundColorIndex,
    @nullable int darkContentForegroundColorIndex,
  }) = _ReadingSettings;
}
