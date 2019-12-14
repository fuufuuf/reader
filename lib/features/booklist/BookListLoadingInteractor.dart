import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:timnew_reader/features/booklist/BookListInteractor.dart';
import 'package:timnew_reader/features/splash/SplashScreen.dart';
import 'package:timnew_reader/legacy/models/BookIndex.dart';

class BookListLoadingInteractorWidget extends StatelessWidget {
  final WidgetBuilder childBuilder;

  BookListLoadingInteractorWidget({@required this.childBuilder});

  Future<BuiltList<BookIndex>> get futureBookList =>
      Future.delayed(Duration(seconds: 1)).then((_) => BuiltList.of([]));

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
