class Book {
  Book(this.url,
      {this.enforceGbk = false, this.title, this.author, this.chapters});

  final String url;
  final bool enforceGbk;

  bool get isLoaded => chapters != null;

  String title;

  String author;

  List<Chapter> chapters;
}

class Chapter {
  Chapter(this.url, this.title, {this.content});

  final String url;
  String title;

  bool get isLoaded => content != null;

  List<String> content;
}
