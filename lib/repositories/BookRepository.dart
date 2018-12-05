import 'dart:convert';

import 'package:reader/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookRepository {
  static final String _bookListKey = "book_list";

  static Map<String, Book> _books;

  static Future<List<Book>> _asList() =>
      Future.value(_books.values.toList(growable: false));

  static Future<List<Book>> loadBooks({reload: false}) =>
      (_books == null || reload)
          ? _doLoadAll().then(() => _asList())
          : _asList();

  static saveBooks() async {
    final prefs = await SharedPreferences.getInstance();

    final value = _books.values
        .map((b) => {'url': b.urlString, 'author': b.author, 'title': b.title})
        .map(json.encode)
        .toList(growable: false);

    await prefs.setStringList(_bookListKey, value);
  }

  static deleteBook(Book book) async {
    _books.remove(book);
    await saveBooks();
  }

  static Book findOrAddBook(String url) =>
      _books.containsKey(url) ? _books[url] : _books[url] = Book.url(url);

  static _doLoadAll() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.getStringList(_bookListKey).forEach(_updateBook);
  }
  
  static void _updateBook(String jsonString) {
    final Map<String, dynamic> data = json.decode(jsonString);

    final Book book = findOrAddBook(data['url']);

    book.author = data['author'];
    book.title = data['title'];
  }
}
