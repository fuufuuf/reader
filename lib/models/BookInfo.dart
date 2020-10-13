import 'package:freezed_annotation/freezed_annotation.dart';

part 'BookInfo.freezed.dart';

@freezed
abstract class BookInfo implements _$BookInfo {
  BookInfo._();

  factory BookInfo({
    @required Uri url,
    @required Uri chapterListUrl,
    @required String bookId,
    @required String title,
    String author,
    String genre,
    String completeness,
    String lastUpdated,
    String length,
  }) = _BookInfo;

  bool get hasAuthor => author != null;

  bool get hasGenre => genre != null;

  bool get hasCompleteness => completeness != null;

  bool get hasLastUpdated => lastUpdated != null;

  bool get hasLength => length != null;
}
