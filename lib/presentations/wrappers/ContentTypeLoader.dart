import 'package:flutter/widgets.dart';
import 'package:reader/models/Book.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/models/TableOfContents.dart';
import 'package:reader/presentations/screens/BookInfoScreen.dart';
import 'package:reader/presentations/screens/ErrorScreen.dart';
import 'package:reader/presentations/screens/LoadingScreen.dart';
import 'package:reader/presentations/screens/ChapterListScreen.dart';
import 'package:reader/presentations/screens/ReadingScreen.dart';
import 'package:reader/presentations/wrappers/ContentLoader.dart';
import 'package:reader/repositories/network/BookRepository.dart';

class ContentTypeLoader extends StatelessWidget {
  final Uri url;
  final Future<Type> contentType;

  ContentTypeLoader(this.url, this.contentType);

  ContentTypeLoader.loadBook(Uri url) : this(url, Future.value(Book));

  ContentTypeLoader.loadMenu(Uri url)
      : this(url, Future.value(TableOfContents));

  ContentTypeLoader.loadChapter(Uri url)
      : this(url, Future.value(ChapterContent));

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

        case TableOfContents:
          return renderMenu();

        case ChapterContent:
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
      render: (book) => BookInfoScreen(book: book));

  Widget renderMenu() =>
      ContentLoader<TableOfContents>(
      url: url,
      action: BookRepository.openMenu,
      render: (menu) => ChapterListScreen(menu: menu));

  Widget renderChapter() =>
      ContentLoader<ChapterContent>(
      url: url,
      action: BookRepository.openChapter,
          render: (chapter) => ReadingScreen(chapter: chapter));

  Widget renderError(Object error) => ErrorScreen(error: error);

  Widget renderLoading() => LoadingScreen();
}
