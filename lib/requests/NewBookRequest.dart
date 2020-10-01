import 'package:timnew_reader/models/NewBook.dart';

import 'package:timnew_reader/repositories/network/BookRepository.dart';
import 'package:timnew_reader/repositories/settings/BookIndexRepository.dart';

class NewBookRequest {
  final String url;
  final Future<NewBook> futureNewBook;

  NewBookRequest(this.url) : futureNewBook = _execute(url);

  static Iterable<NewBookRequest> fromUrlInput(String text) {
    if (text.isEmpty) {
      return Iterable.empty();
    }

    return text.split("\n").map((e) => e.trim()).where((element) => element.isNotEmpty).map((e) => NewBookRequest(e));
  }

  static Future<NewBook> _execute(String url) async {
    final newBook = await BookRepository.createBookByUrlString(url).timeout(Duration(seconds: 30));

    if (!BookIndexRepository.isBookExists(newBook.bookId)) {
      await newBook.save();
    }

    return newBook;
  }
}
