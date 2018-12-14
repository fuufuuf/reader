import 'package:flutter/widgets.dart';
import 'package:reader/presentations/screens/ErrorScreen.dart';
import 'package:reader/presentations/screens/LoadingScreen.dart';

class ContentLoader<T> extends StatelessWidget {
  final Uri url;
  final LoadAction<T> action;
  final ContentRender<T> render;

  ContentLoader({this.url, this.action, this.render});

  @override
  Widget build(BuildContext context) => FutureBuilder<T>(
        key: Key("ContentLoader<$T>"),
        future: action(url),
        builder: renderChild,
      );

  Widget renderChild(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (snapshot.hasData) {
      return render(snapshot.data);
    }

    if (snapshot.hasError) {
      return ErrorScreen(error: snapshot.error);
    }

    return LoadingScreen();
  }
}

typedef Future<T> LoadAction<T>(Uri url);
typedef Widget ContentRender<T>(T content);
