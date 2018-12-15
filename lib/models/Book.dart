import 'package:meta/meta.dart';

class Book {
  final Uri url;
  final Uri menuUrl;
  final String title;
  final String author;
  final String genre;
  final String completeness;
  final String lastUpdated;
  Book({
    @required this.url,
    @required this.menuUrl,
    @required this.title,
    this.author,
    this.genre,
    this.completeness,
    this.lastUpdated,
    this.length
  });

  final String length;

  bool get hasAuthor => author != null;

  bool get hasGenre => genre != null;

  bool get hasCompleteness => completeness != null;

  bool get hasLastUpdated => lastUpdated != null;

  bool get hasLength => length != null;
}
