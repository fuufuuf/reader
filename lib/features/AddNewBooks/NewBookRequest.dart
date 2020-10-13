import 'dart:async';

import 'package:timnew_reader/features/BookList/BookListRequest.dart';
import 'package:timnew_reader/features/App/UserException.dart';
import 'package:timnew_reader/arch/Request.dart';
import 'package:timnew_reader/models/NewBook.dart';

import 'package:timnew_reader/repositories/network/BookRepository.dart';

class NewBookRequest extends Request<NewBook> {
  final BookListRequest bookList;
  final String url;

  NewBookRequest(this.bookList, this.url);

  @override
  FutureOr<NewBook> load() async {
    final newBook = await BookRepository.parseNewBook(url)
        .timeout(Duration(seconds: 5), onTimeout: () => Future.error(UserException("加載超時")));

    if (bookList.isDuplicated(newBook.bookId)) {
      return newBook.markAsDuplicated();
    } else {
      return newBook;
    }
  }
}
