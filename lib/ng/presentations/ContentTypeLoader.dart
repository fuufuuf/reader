import 'package:flutter/widgets.dart';
import 'package:reader/ng/models/Book.dart';
import 'package:reader/ng/models/Chapter.dart';
import 'package:reader/ng/models/Menu.dart';
import 'package:reader/ng/presentations/BookView.dart';
import 'package:reader/ng/presentations/ChapterView.dart';
import 'package:reader/ng/presentations/ContentLoader.dart';
import 'package:reader/ng/presentations/ErrorView.dart';
import 'package:reader/ng/presentations/LoadingView.dart';
import 'package:reader/ng/presentations/MenuView.dart';
import 'package:reader/ng/repositories/BookRepository.dart';

class ContentTypeLoader extends StatelessWidget {
  final Uri url;
  final Future<Type> contentType;

  ContentTypeLoader(this.url, this.contentType);

  ContentTypeLoader.loadBook(Uri url) : this(url, Future.value(Book));

  ContentTypeLoader.loadMenu(Uri url) : this(url, Future.value(Menu));

  ContentTypeLoader.loadChapter(Uri url) : this(url, Future.value(Chapter));

  ContentTypeLoader.loadFromUri(Uri url)
      : this(url, BookRepository.checkType(url));

  ContentTypeLoader.loadFromUriString(String url)
      : this(Uri.parse(url), BookRepository.checkType(Uri.parse(url)));

  @override
  Widget build(BuildContext context) => FutureBuilder<Type>(
      key: const Key("contentLoader"),
      future: contentType,
      builder: buildChild);

  Widget buildChild(BuildContext context, AsyncSnapshot<Type> snapshot) {
    if (snapshot.hasData) {
      switch (snapshot.data) {
        case Book:
          return renderBook();

        case Menu:
          return renderMenu();

        case Chapter:
          return renderChapter();
      }
    }

    if (snapshot.hasError) {
      return ErrorView(error: snapshot.error);
    }

    return LoadingView();
  }

  Widget renderBook() => ContentLoader<Book>(
      url: url,
      action: BookRepository.openBook,
      render: (book) => BookView(book: book));

  Widget renderMenu() => ContentLoader<Menu>(
      url: url,
      action: BookRepository.openMenu,
      render: (menu) => MenuView(menu: menu));

  Widget renderChapter() => ContentLoader<Chapter>(
      url: url,
      action: BookRepository.openChapter,
      render: (chapter) => ChapterView(chapter: chapter));

  Widget renderError(Object error) => ErrorView(error: error);

  Widget renderLoading() => LoadingView();
}
