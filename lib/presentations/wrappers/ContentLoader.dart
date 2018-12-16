import 'package:flutter/widgets.dart';
import 'package:reader/presentations/components/ErrorView.dart';
import 'package:reader/presentations/components/LoadingView.dart';

class ContentLoader<T> extends StatelessWidget {
  final Future<T> future;
  final T initialData;
  final ContentRender<T> render;
  final bool respondToReloading;

  ContentLoader({
    Key key,
    this.future,
    this.initialData,
    @required this.render,
    this.respondToReloading = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      FutureBuilder<T>(
        future: future,
        initialData: initialData,
        builder: renderChild,
      );

  Widget renderChild(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (respondToReloading &&
        snapshot.connectionState == ConnectionState.waiting) {
      return LoadingView();
    }

    if (snapshot.hasData) {
      return render(context, snapshot.data);
    }

    if (snapshot.hasError) {
      return ErrorView(error: snapshot.error);
    }

    return LoadingView();
  }
}

typedef Widget ContentRender<T>(BuildContext context, T content);
