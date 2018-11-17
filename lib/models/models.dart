class Book {
  Book({this.url, this.title, this.author, this.chapters});

  Book.index(this.url);


  final String url;

  bool get isLoaded => chapters != null;

  String title;

  String author;

  List<Chapter> chapters;
}

class Chapter {
  Chapter({this.url, this.title, this.content});

  final String url;
  String title;

  bool get isLoaded => content != null;

  ChapterContent content;
}

class ChapterContent {
  List<String> contents;
}
