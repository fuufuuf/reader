import 'package:timnew_reader/models/NewBook.dart';

import 'package:timnew_reader/repositories/network/BookRepository.dart';
import 'package:timnew_reader/repositories/settings/BookIndexRepository.dart';
import 'package:timnew_reader/requests/Request.dart';

class NewBookRequest extends Request<NewBook> {
  final String url;

  NewBookRequest(this.url);

  @override
  Future<NewBook> execute() async {
    await Future.delayed(Duration(seconds: 1));

    final newBook = await BookRepository.createBookByUrlString(url).timeout(Duration(seconds: 30));

    if (!BookIndexRepository.isBookExists(newBook.bookId)) {
      await newBook.save();
    }

    return newBook;
  }

  static Iterable<NewBookRequest> fromUrlInput(String text) {
    if (text.isEmpty) {
      return Iterable.empty();
    }

    return text.split("\n").map((e) => e.trim()).where((element) => element.isNotEmpty).map((e) => NewBookRequest(e));
  }
}
