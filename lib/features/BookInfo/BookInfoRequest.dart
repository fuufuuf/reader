import 'dart:async';

import 'package:timnew_reader/arch/Request.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/BookInfo.dart';
import 'package:timnew_reader/repositories/network/BookRepository.dart';

class BookInfoRequest extends Request<BookInfo> {
  final BookIndex bookIndex;

  BookInfoRequest(this.bookIndex);

  String get bookName => bookIndex.bookName;

  @override
  Future<BookInfo> load() async {
    return BookRepository.fetchBookInfo(bookIndex.bookInfoUrl);
  }
}
