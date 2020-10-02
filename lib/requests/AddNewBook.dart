import 'package:timnew_reader/models/NewBook.dart';

import 'package:timnew_reader/repositories/network/BookRepository.dart';
import 'package:timnew_reader/repositories/settings/BookIndexRepository.dart';
import 'package:timnew_reader/arch/Store.dart';

class AddNewBook extends Store<NewBook> {
  final String url;

  AddNewBook(this.url);

  @override
  Future<NewBook> initialize() async {
    await Future.delayed(Duration(seconds: 1));

    final newBook = await BookRepository.createBookByUrlString(url).timeout(Duration(seconds: 30));

    if (!BookIndexRepository.isBookExists(newBook.bookId)) {
      await newBook.save();
    }

    return newBook;
  }

  static Iterable<AddNewBook> fromUrlInput(String text) {
    if (text.isEmpty) {
      return Iterable.empty();
    }

    return text.split("\n").map((e) => e.trim()).where((element) => element.isNotEmpty).map((e) => AddNewBook(e));
  }
}
