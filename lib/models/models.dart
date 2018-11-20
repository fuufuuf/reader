import 'package:meta/meta.dart';

abstract class WebContent {
  final Uri url;

  String title;

  WebContent({@required this.url, this.title});

  String get urlString => url.toString();

  String get displayTitle => title ?? url.toString();

  bool get isLoaded;
}

class Book extends WebContent {
  String title;

  String author;

  List<Chapter> chapters;

  Book({@required Uri url, String title, this.author, this.chapters})
      : super(url: url, title: title);

  Book.url(String url) : this(url: Uri.parse(url));

  @override
  bool get isLoaded => chapters != null;
}

class Chapter extends WebContent {
  List<String> content;

  Chapter({@required Uri url, String title, this.content})
      : super(url: url, title: title);

  @override
  bool get isLoaded => content != null;
}
