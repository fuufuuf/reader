part of 'BookListScreen.dart';

class _BookListLoadingWidget extends StatelessWidget {
  final WidgetBuilder childBuilder;

  _BookListLoadingWidget({@required this.childBuilder});

  Future<BuiltList<BookIndex>> get futureBookList =>
      BookIndexRepository.loadAllBooks();

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: futureBookList,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SplashScreen();
        } else {
          return _BookListInteractorWidget(
              books: snapshot.data, child: childBuilder(context));
        }
      });
}
