import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:timnew_reader/features/booklist/BookIndexRepository.dart';
import 'package:timnew_reader/features/booklist/BookListInteractor.dart';
import 'package:timnew_reader/features/splash/SplashScreen.dart';
import 'package:timnew_reader/models/book_models.dart';

class BookListLoadingInteractorWidget extends StatelessWidget {
  final WidgetBuilder childBuilder;

  BookListLoadingInteractorWidget({@required this.childBuilder});

  Future<BuiltList<BookIndex>> get futureBookList =>
      BookIndexRepository.loadAllBooks();

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: futureBookList,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SplashScreen();
        } else {
          return BookListInteractorWidget(
              books: snapshot.data, child: childBuilder(context));
        }
      });
}
