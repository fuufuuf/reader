// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookIndex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BookIndex _$_$_BookIndexFromJson(Map<String, dynamic> json) {
  return _$_BookIndex(
    bookId: json['bookId'] as String,
    bookName: json['bookName'] as String,
    bookInfoUrl: json['bookInfoUrl'] == null
        ? null
        : Uri.parse(json['bookInfoUrl'] as String),
    chapterListUrl: json['chapterListUrl'] == null
        ? null
        : Uri.parse(json['chapterListUrl'] as String),
  );
}

Map<String, dynamic> _$_$_BookIndexToJson(_$_BookIndex instance) =>
    <String, dynamic>{
      'bookId': instance.bookId,
      'bookName': instance.bookName,
      'bookInfoUrl': instance.bookInfoUrl?.toString(),
      'chapterListUrl': instance.chapterListUrl?.toString(),
    };
