import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Store.dart';

class DefaultRenders {
  static DataWidgetBuilder<Object> _customErrorBuilder;
  static WidgetBuilder _customWaitingBuilder;

  static void registerDefaultErrorBuilder(DataWidgetBuilder<Object> builder) {
    _customErrorBuilder = builder;
  }

  static void registerDefaultWaitingBuilder(WidgetBuilder builder) {
    _customWaitingBuilder = builder;
  }

  static Widget buildError(BuildContext context, Object error) {
    if (_customErrorBuilder != null) return _customErrorBuilder(context, error);

    final errorColor = Theme.of(context).errorColor;

    return Center(
      child: Row(children: [
        Icon(Icons.error_outline, color: errorColor),
        Text(error.toString(), style: TextStyle(color: errorColor)),
      ]),
    );
  }

  static Widget buildWaiting(BuildContext context) {
    if (_customWaitingBuilder != null) return _customWaitingBuilder(context);

    return Center(child: CircularProgressIndicator(value: null));
  }
}

mixin RenderData<T> {
  Widget buildData(BuildContext context, T data);
}

mixin RenderResult<T> implements RenderData<T> {
  Widget buildError(BuildContext context, Object error) => DefaultRenders.buildError(context, error);
}

mixin RenderAsyncResult<T> implements RenderResult<T> {
  Widget buildError(BuildContext context, Object error) => DefaultRenders.buildError(context, error);

  Widget buildInitialState(BuildContext context) => buildWaiting(context);

  Widget buildWaiting(BuildContext context) => DefaultRenders.buildWaiting(context);
}

mixin WithEmptyContent<T> implements RenderData<T> {
  bool checkEmpty(T data);

  Widget buildContent(BuildContext context, T content);

  Widget buildEmpty(BuildContext context);

  Widget buildData(BuildContext context, T data) {
    if (checkEmpty(data)) return buildEmpty(context);
    return buildContent(context, data);
  }
}

mixin RenderAsyncSnapshot<T> implements RenderAsyncResult<T> {
  Widget buildError(BuildContext context, Object error) => DefaultRenders.buildError(context, error);

  Widget buildInitialState(BuildContext context) => buildWaiting(context);

  Widget buildWaiting(BuildContext context) => DefaultRenders.buildWaiting(context);

  Widget buildAsyncSnapshot(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (snapshot.hasError) return buildError(context, snapshot.error);
    if (snapshot.hasData) return buildData(context, snapshot.data);

    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return buildInitialState(context);
      case ConnectionState.waiting:
        return buildWaiting(context);
      case ConnectionState.active:
        if (snapshot.hasError) return buildError(context, snapshot.error);
        if (snapshot.hasData) return buildData(context, snapshot.data);
        return buildWaiting(context);
      default:
        if (snapshot.hasError) return buildError(context, snapshot.error);
        if (snapshot.hasData) return buildData(context, snapshot.data);
        throw StateError("Bad AsyncSnapshot $snapshot}");
    }
  }

  Widget buildFuture(Future<T> future, {Key key, T initialData}) =>
      FutureBuilder(key: key, future: future, builder: buildAsyncSnapshot, initialData: initialData);

  Widget buildStream(Stream<T> stream, {Key key, T initialData}) =>
      StreamBuilder(key: key, stream: stream, builder: buildAsyncSnapshot, initialData: initialData);
}

mixin RenderValueStore<T> implements RenderData<T> {
  Widget buildValueStore(ValueStore<T> store, {Key key}) => ValueListenableBuilder(
      key: key, valueListenable: store, builder: (BuildContext context, T value, _) => buildData(context, value));
}

mixin RenderResultListenable<T> implements RenderResult<T> {
  Widget buildError(BuildContext context, Object error) => DefaultRenders.buildError(context, error);

  Widget buildResultStore(ResultStore<T> store, {Key key}) => ValueListenableBuilder(
        key: key,
        valueListenable: store.listenable,
        builder: (BuildContext context, Result<T> value, _) {
          if (value.isValue) {
            return buildData(context, value.asValue.value);
          } else {
            return buildError(context, value.asError.error);
          }
        },
      );
}
