import 'dart:async';

import 'package:timnew_reader/app/BookList/BookList.dart';
import 'package:timnew_reader/arch/Request.dart';
import 'package:timnew_reader/models/NewBook.dart';

import 'package:timnew_reader/repositories/network/BookRepository.dart';

class NewBookRequest extends Request<NewBook> {
  final BookList bookList;
  final String url;

  NewBookRequest(this.bookList, this.url);

  @override
  FutureOr<NewBook> execute() async {
    final newBook = await BookRepository.createBookByUrlString(url)
        .timeout(Duration(seconds: 5), onTimeout: () => Future.error(Exception("加載超時")));

    if (bookList.isDuplicated(newBook.bookId)) {
      return newBook.markAsDuplicated();
    } else {
      final storage = bookList.storage;
      await storage.saveBookIndex(newBook.bookIndex);
      await bookList.add(newBook.bookIndex);

      if (newBook.hasCurrentChapterUrl) {
        await storage.saveCurrentChapter(newBook.bookId, newBook.currentChapterUrl);
      }

      return newBook;
    }
  }
}
