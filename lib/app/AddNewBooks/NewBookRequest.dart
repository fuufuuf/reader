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
    print(1);
    final newBook = await BookRepository.createBookByUrlString(url)
        .timeout(Duration(seconds: 5), onTimeout: () => Future.error(Exception("加載超時")));

    print(2);

    if (await bookList.isDuplicated(newBook.bookId)) {
      print(3);
      return newBook.markAsDuplicated();
    } else {
      print(4);
      final storage = await bookList.storage;
      print(5);
      await storage.saveBookIndex(newBook.bookIndex);
      print(6);
      await bookList.add(newBook.bookIndex);
      print(7);

      if (newBook.hasCurrentChapterUrl) {
        print(8);

        await storage.saveCurrentChapter(newBook.bookId, newBook.currentChapterUrl);
        print(9);

      }
      print(10);

      return newBook;
    }
  }
}
