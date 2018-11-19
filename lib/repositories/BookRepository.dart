import 'package:reader/models/models.dart';
import 'package:reader/network/Downloader.dart';

class BookRepository {
  List<Book> _books = <Book>[
    Book.index("https://www.piaotian.com/html/9/9054")
  ];

  Future<List<Book>> loadBooks() => Future.wait(_books.map(_loadBook));

  Future<List<Book>> sampleData() => Future.value(<Book>[
        Book(Uri.parse("https://www.piaotian.com/html/9/9054"),
            title: "大道朝天", author: "猫腻"),
        Book(Uri.parse("https://www.piaotian.com/html/9/9054"),
            title: "将夜", author: "猫腻"),
        Book(Uri.parse("https://www.piaotian.com/html/9/9054"),
            title: "择天记", author: "猫腻"),
      ]);

  Future<Book> _loadBook(Book book) =>
      Downloader.findDownloader(book).fetchBook(book);
}
