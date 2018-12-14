import 'package:flutter/widgets.dart';
import 'package:reader/models/Book.dart';
import 'package:reader/models/Chapter.dart';
import 'package:reader/models/Menu.dart';
import 'package:reader/presentations/screens/BookScreen.dart';
import 'package:reader/presentations/screens/ChapterScreen.dart';
import 'package:reader/presentations/screens/ErrorScreen.dart';
import 'package:reader/presentations/screens/LoadingScreen.dart';
import 'package:reader/presentations/screens/MenuScreen.dart';
import 'package:reader/presentations/wrappers/ContentLoader.dart';
import 'package:reader/repositories/BookRepository.dart';

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
      return ErrorScreen(error: snapshot.error);
    }

    return LoadingScreen();
  }

  Widget renderBook() => ContentLoader<Book>(
      url: url,
      action: BookRepository.openBook,
      render: (book) => BookScreen(book: book));

  Widget renderMenu() => ContentLoader<Menu>(
      url: url,
      action: BookRepository.openMenu,
      render: (menu) => MenuScreen(menu: menu));

  Widget renderChapter() => ContentLoader<Chapter>(
      url: url,
      action: BookRepository.openChapter,
      render: (chapter) => ChapterScreen(chapter: chapter));

  Widget renderError(Object error) => ErrorScreen(error: error);

  Widget renderLoading() => LoadingScreen();
}
