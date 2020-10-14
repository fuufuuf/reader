// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReadingSettings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReadingSettings _$_$_ReadingSettingsFromJson(Map<String, dynamic> json) {
  return _$_ReadingSettings(
    readingTextScaleFactor:
        (json['readingTextScaleFactor'] as num)?.toDouble() ?? 1.0,
    readingLineSpaceScaleFactor:
        (json['readingLineSpaceScaleFactor'] as num)?.toDouble() ?? 1.0,
    lightContentForegroundColorIndex:
        json['lightContentForegroundColorIndex'] as int,
    darkContentForegroundColorIndex:
        json['darkContentForegroundColorIndex'] as int,
  );
}

Map<String, dynamic> _$_$_ReadingSettingsToJson(_$_ReadingSettings instance) =>
    <String, dynamic>{
      'readingTextScaleFactor': instance.readingTextScaleFactor,
      'readingLineSpaceScaleFactor': instance.readingLineSpaceScaleFactor,
      'lightContentForegroundColorIndex':
          instance.lightContentForegroundColorIndex,
      'darkContentForegroundColorIndex':
          instance.darkContentForegroundColorIndex,
    };
