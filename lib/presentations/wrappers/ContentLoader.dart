import 'package:flutter/widgets.dart';
import 'package:reader/presentations/screens/ErrorScreen.dart';
import 'package:reader/presentations/screens/LoadingScreen.dart';

class ContentLoader<T> extends StatelessWidget {
  final Future<T> future;
  final ContentRender<T> render;

  ContentLoader({Key key, this.future, this.render}) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder<T>(
        future: future,
        builder: renderChild,
      );

  Widget renderChild(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (snapshot.hasData) {
      return render(context, snapshot.data);
    }

    if (snapshot.hasError) {
      return ErrorScreen(error: snapshot.error);
    }

    return LoadingScreen();
  }
}

typedef Widget ContentRender<T>(BuildContext context, T content);
