import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DefaultRenders {
  static Widget buildError(BuildContext context, Object error) {
    final errorColor = Theme.of(context).errorColor;

    return Center(
      child: Row(children: [
        Icon(Icons.error_outline, color: errorColor),
        Text(error.toString(), style: TextStyle(color: errorColor)),
      ]),
    );
  }

  static Widget buildBusy(BuildContext context) => Center(child: CircularProgressIndicator(value: null));
}

mixin RenderData<T> {
  Widget buildData(BuildContext context, T data);
}

mixin RenderResult<T> implements RenderData<T> {
  Widget buildError(BuildContext context, Object error) => DefaultRenders.buildError(context, error);
}

mixin RenderAsyncResult<T> implements RenderResult<T> {
  Widget buildError(BuildContext context, Object error) => DefaultRenders.buildError(context, error);

  Widget buildInitialState(BuildContext context) => buildBusy(context);

  Widget buildBusy(BuildContext context) => DefaultRenders.buildBusy(context);
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

  Widget buildInitialState(BuildContext context) => buildBusy(context);

  Widget buildBusy(BuildContext context) => DefaultRenders.buildBusy(context);

  Widget buildAsyncSnapshot(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (snapshot.hasError) return buildError(context, snapshot.error);
    if (snapshot.hasData) return buildData(context, snapshot.data);

    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return buildInitialState(context);
      case ConnectionState.waiting:
        return buildBusy(context);
      default:
        if (snapshot.hasError) return buildError(context, snapshot.error);
        if (snapshot.hasData) return buildData(context, snapshot.data);
        throw StateError("Bad AsyncSnapshot $snapshot}");
    }
  }

  Widget buildFuture(Future<T> future, {Key key, T initialData}) =>
      FutureBuilder(key: key, builder: buildAsyncSnapshot, initialData: initialData);

  Widget buildStream(Future<T> future, {Key key, T initialData}) =>
      FutureBuilder(key: key, builder: buildAsyncSnapshot, initialData: initialData);
}

mixin RenderValueListenable<T> implements RenderData<T> {
  Widget renderValueListenable(ValueListenable<T> listenable, {Key key}) => ValueListenableBuilder(
      key: key, valueListenable: listenable, builder: (BuildContext context, T value, _) => buildData(context, value));
}

mixin RenderResultListenable<T> implements RenderResult<T> {
  Widget buildError(BuildContext context, Object error) => DefaultRenders.buildError(context, error);

  Widget renderValueListenable(ValueListenable<Result<T>> listenable, {Key key}) => ValueListenableBuilder(
        key: key,
        valueListenable: listenable,
        builder: (BuildContext context, Result<T> value, _) {
          if (value.isValue) {
            return buildData(context, value.asValue.value);
          } else {
            return buildError(context, value.asError.error);
          }
        },
      );
}
