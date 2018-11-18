abstract class WebContent {
  final Uri url;
  String title;

  WebContent(this.url);
}

class Book implements WebContent {
  Book(url, {this.title, this.author, this.chapters}) : url = Uri.parse(url);

  final Uri url;

  String get urlString => url.toString();

  bool get isLoaded => chapters != null;

  String title;

  String author;

  List<Chapter> chapters;
}

class Chapter implements WebContent {
  Chapter(this.url, this.title, {this.content});

  final Uri url;

  String get urlString => url.toString();

  String title;

  bool get isLoaded => content != null;

  List<String> content;
}
