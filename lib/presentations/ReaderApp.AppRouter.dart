import 'package:flutter/material.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/presentations/screens/BookInfoScreen.dart';
import 'package:reader/presentations/screens/BookListScreen.dart';
import 'package:reader/presentations/screens/ChapterListScreen.dart';
import 'package:reader/presentations/screens/NotFoudnScreen.dart';
import 'package:reader/presentations/screens/ReadingScreen.dart';
import 'package:reader/presentations/wrappers/ContentLoader.dart';
import 'package:reader/repositories/settings/BookEntryRepository.dart';
import 'package:reader/viewModels/BookEntryList.dart';

class AppRouter {
  get initialRoute => rootPath;

  Route generateRoute(RouteSettings settings) {
    Uri uri = Uri.parse(settings.name);

    switch (uri.path) {
      case rootPath:
        return buildBookList();
      case bookInfoPath:
        return buildBookInfo(uri);
      case bookChaptersPath:
        return buildChapterList(uri);
      case bookReaderPath:
        return buildReader(uri);
      default:
        return null;
    }
  }

  static const rootPath = '/';
  static const bookInfoPath = '/book/info';
  static const bookChaptersPath = '/book/chapters';
  static const bookReaderPath = '/book/reader';
  static const _bookIdKey = 'bookId';
  static const _contentUrlKey = 'contentUrl';

  static String buildBookPath(String pathName, String bookId) =>
      Uri(path: pathName, queryParameters: {_bookIdKey: bookId}).toString();

  static Future<Object> openBookInfo(BuildContext context, BookEntry entry) =>
      Navigator.pushNamed(
          context, AppRouter.buildBookPath(AppRouter.bookInfoPath, entry.id));

  static Future<Object> openBookChapters(BuildContext context, BookEntry entry) =>
      Navigator.pushNamed(context,
          AppRouter.buildBookPath(AppRouter.bookChaptersPath, entry.id));

  static Future<Object> openBookReader(BuildContext context, BookEntry entry,
      Uri chapterContentUrl) =>
      Navigator.pushNamed(
          context, Uri(path: AppRouter.bookReaderPath,
          queryParameters: {
            _bookIdKey: entry.id,
            _contentUrlKey: chapterContentUrl.toString()
          }).toString());

  Route onUnknownRoute(RouteSettings settings) =>
      buildRoute((BuildContext context) => NotFoundScreen());

  Route buildRoute(WidgetBuilder builder) =>
      MaterialPageRoute(builder: builder);

  Route buildBookList() =>
      buildRoute((BuildContext context) => ContentLoader<BookEntryList>(
          future: BookEntryList.create(),
          render: (BuildContext context, BookEntryList entryList) =>
              BookListScreen(entryList)));

  Route buildBookInfo(Uri uri) =>
      buildRoute((BuildContext context) =>
          BookInfoScreen(
              bookEntry: BookEntryRepository.fetchEntry(uri.queryParameters[_bookIdKey])
          )
      );

  Route buildChapterList(Uri uri) =>
      buildRoute((BuildContext context) =>
          ChapterListScreen(
              bookEntry: BookEntryRepository.fetchEntry(
                  uri.queryParameters[_bookIdKey])
          )
      );

  Route buildReader(Uri uri) =>
      buildRoute((BuildContext context) =>
          ReadingScreen(
              bookEntry: BookEntryRepository.fetchEntry(
                  uri.queryParameters[_bookIdKey]),
              contentUrl: Uri.parse(uri.queryParameters[_contentUrlKey])
          )
      );
}
