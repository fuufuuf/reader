import 'package:flutter/material.dart';
import 'package:reader/presentations/screens/BookInfoScreen.dart';
import 'package:reader/presentations/screens/BookListScreen.dart';
import 'package:reader/presentations/screens/ChapterListScreen.dart';
import 'package:reader/presentations/screens/NotFoudnScreen.dart';
import 'package:reader/presentations/screens/ReadingScreen.dart';
import 'package:reader/repositories/settings/BookIndexRepository.dart';

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

  static Future<Object> openBookInfo(BuildContext context, String bookId) =>
      Navigator.pushNamed(
          context, Uri(path: AppRouter.bookInfoPath,
          queryParameters: {AppRouter._bookIdKey: bookId}).toString());

  static Future<Object> openBookChapters(BuildContext context, String bookId,
      {bool openReaderIfPossible: false}) {
    Future<Object> originalResult =
    Navigator.pushNamed(
        context, Uri(path: AppRouter.bookChaptersPath,
        queryParameters: {AppRouter._bookIdKey: bookId}).toString());

    if (openReaderIfPossible &&
        BookIndexRepository.hasCurrentChapterUrl(bookId)) {
      openBookReader(
          context, bookId, BookIndexRepository.loadCurrentChapter(bookId));
    }

    return originalResult;
  }

  static Future<Object> openBookReader(BuildContext context, String bookId,
      Uri chapterContentUrl) =>
      Navigator.pushNamed(
          context, Uri(path: AppRouter.bookReaderPath,
          queryParameters: {
            _bookIdKey: bookId,
            _contentUrlKey: chapterContentUrl.toString()
          }).toString());

  Route onUnknownRoute(RouteSettings settings) =>
      buildRoute((BuildContext context) => NotFoundScreen());

  Route buildRoute(WidgetBuilder builder) =>
      MaterialPageRoute(builder: builder);

  Route buildBookList() =>
      buildRoute((BuildContext context) => BookListScreen());

  Route buildBookInfo(Uri uri) =>
      buildRoute((BuildContext context) =>
          BookInfoScreen(
              bookId: uri.queryParameters[_bookIdKey]
          )
      );

  Route buildChapterList(Uri uri) =>
      buildRoute((BuildContext context) =>
          ChapterListScreen(bookId: uri.queryParameters[_bookIdKey])
      );

  Route buildReader(Uri uri) =>
      buildRoute((BuildContext context) =>
          ReadingScreen(
              bookId: uri.queryParameters[_bookIdKey],
              contentUrl: Uri.parse(uri.queryParameters[_contentUrlKey])
          )
      );
}
