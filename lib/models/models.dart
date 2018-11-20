import 'package:meta/meta.dart';
import 'package:reader/network/Downloader.dart';

abstract class WebContent<T> {
  final Uri url;

  String title;

  WebContent({@required this.url, this.title});

  String get urlString => url.toString();

  bool get isMetaLoaded => title != null;

  String get displayTitle => isMetaLoaded ? title : urlString;

  bool get isLoaded;

  Downloader get _downloader => Downloader.findDownloader(this);

  Future<T> load({bool reload: false}) =>
      (!isLoaded || reload) ? _download() : Future.value(this as T);

  Future<T> _download();
}

class BookList {
  static Future<List<Book>> loadAll() => Future.value(<Book>[
        Book.url("https://www.piaotian.com/html/9/9054/"),
        Book.url("https://www.piaotian.com/html/5/5623/"),
        Book.url("https://www.piaotian.com/html/8/8491/")
      ]);
}

class Book extends WebContent<Book> {
  String title;

  String author;

  List<Chapter> chapters;

  Book({@required Uri url, String title, this.author, this.chapters})
      : super(url: url, title: title);

  Book.url(String url) : this(url: Uri.parse(url));

  @override
  bool get isLoaded => chapters != null;

  @override
  Future<Book> _download() => _downloader.loadBook(this);
}

class Chapter extends WebContent<Chapter> {
  List<String> content;

  Chapter({@required Uri url, String title, this.content})
      : super(url: url, title: title);

  @override
  bool get isLoaded => content != null;

  @override
  Future<Chapter> _download() => _downloader.loadChapter(this);
}
