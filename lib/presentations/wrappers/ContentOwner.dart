import 'package:flutter/widgets.dart';
import 'package:reader/presentations/wrappers/ContentLoader.dart';

class ContentOwner<T> extends StatefulWidget {
  final ContentRender<T> render;
  final Future<T> future;

  const ContentOwner({Key key, this.render, this.future})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      ContentState(render: render, future: future);
}

class ContentState<T> extends State<ContentOwner<T>> {
  final ContentRender<T> render;

  Future<T> future;

  ContentState({@required this.render, @required this.future});

  void syncUpdate(ContentUpdater<T> updater) {
    setState(() {
      this.future = updater(future);
    });
  }

  void asyncUpdate(ContentUpdater<T> updater) async {
    try {
      final T newValue = await updater(future);

      setState(() {
        future = Future.value(newValue);
      });
    } catch (ex) {
      setState(() {
        future = Future.error(ex);
      });
    }
  }

  @override
  Widget build(BuildContext context) => ContentApi<T>(
      asyncUpdateApi: asyncUpdate,
      syncUpdateApi: syncUpdate,
      child: ContentLoader(
        future: future,
        render: render,
      ));
}

typedef void InvokeUpdater<T>(ContentUpdater<T> updater);
typedef Future<T> ContentUpdater<T>(Future<T> currentValue);

class ContentApi<T> extends InheritedWidget {
  final InvokeUpdater<T> asyncUpdateApi;
  final InvokeUpdater<T> syncUpdateApi;

  ContentApi(
      {@required this.asyncUpdateApi,
      @required this.syncUpdateApi,
      Key key,
      Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    final oldConsole = oldWidget as ContentApi<T>;

    return oldConsole == null ||
        (oldConsole.syncUpdateApi != syncUpdateApi) ||
        (oldConsole.asyncUpdateApi != asyncUpdateApi);
  }

  static Type _typeOf<T>() => T;

  static ContentApi<T> of<T>(BuildContext context) =>
      context.inheritFromWidgetOfExactType(_typeOf<ContentApi<T>>())
          as ContentApi<T>;

  static void asyncUpdate<T>(BuildContext context, ContentUpdater<T> updater) =>
      of<T>(context).asyncUpdateApi(updater);

  static void syncUpdate<T>(BuildContext context, ContentUpdater<T> updater) =>
      of<T>(context).syncUpdateApi(updater);
}
