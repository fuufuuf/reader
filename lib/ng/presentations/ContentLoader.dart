import 'package:flutter/widgets.dart';
import 'package:reader/ng/presentations/ErrorView.dart';
import 'package:reader/ng/presentations/LoadingView.dart';

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
      return ErrorView(error: snapshot.error);
    }

    return LoadingView();
  }
}

typedef Future<T> LoadAction<T>(Uri url);
typedef Widget ContentRender<T>(T content);
