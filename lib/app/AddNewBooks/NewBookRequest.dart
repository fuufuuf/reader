import 'package:timnew_reader/models/NewBook.dart';

import 'package:timnew_reader/repositories/network/BookRepository.dart';
import 'package:timnew_reader/arch/ValueSource.dart';

import 'BookList/BookList.dart';

class NewBookRequest extends ValueSource<NewBook> {
  final BookList bookList;
  final String url;

  NewBookRequest(this.bookList, this.url);

  @override
  Future<NewBook> initialize() async {
    await Future.delayed(Duration(seconds: 1));

    final newBook = await BookRepository.createBookByUrlString(url).timeout(Duration(seconds: 30));

    if (await bookList.isDuplicated(newBook.bookId)) {
      return newBook.markAsDuplicated();
    } else {
      final storage = await bookList.storage;

      await storage.saveBookIndex(newBook.bookIndex);

      await bookList.add(newBook.bookIndex);

      if (newBook.hasCurrentChapterUrl) {
        await storage.saveCurrentChapter(newBook.bookId, newBook.currentChapterUrl);
      }

      return newBook;
    }
  }
}
