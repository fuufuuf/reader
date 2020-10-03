import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ValueSource.dart';

typedef DataWidgetBuilder<T> = Widget Function(BuildContext context, T data);

abstract class AsyncValueBuilder<T> extends StatelessWidget {
  final bool waitForDone;

  final DataWidgetBuilder<T> dataBuilder;
  final DataWidgetBuilder<Object> errorBuilder;

  final WidgetBuilder waitingBuilder;
  final WidgetBuilder activeBuilder;
  final WidgetBuilder noneBuilder;

  factory AsyncValueBuilder.future(
          {Key key,
          @required Future<T> source,
          bool waitForDone: false,
          @required DataWidgetBuilder<T> dataBuilder,
          DataWidgetBuilder<Object> errorBuilder: defaultErrorBuilder,
          WidgetBuilder waitingBuilder: defaultWaitingBuilder,
          WidgetBuilder activeBuilder,
          WidgetBuilder noneBuilder}) =>
      FutureValueBuilder(
          key, source, waitForDone, dataBuilder, errorBuilder, waitingBuilder, activeBuilder, noneBuilder);

  factory AsyncValueBuilder.stream(
          {Key key,
          @required Stream<T> source,
          bool waitForDone: false,
          @required DataWidgetBuilder<T> dataBuilder,
          DataWidgetBuilder<Object> errorBuilder: defaultErrorBuilder,
          WidgetBuilder waitingBuilder: defaultWaitingBuilder,
          WidgetBuilder activeBuilder,
          WidgetBuilder noneBuilder}) =>
      StreamValueBuilder(
          key, source, waitForDone, dataBuilder, errorBuilder, waitingBuilder, activeBuilder, noneBuilder);

  factory AsyncValueBuilder.valueSource(
          {Key key,
          @required ValueSource<T> source,
          @required DataWidgetBuilder<T> dataBuilder,
          DataWidgetBuilder<Object> errorBuilder: defaultErrorBuilder,
          WidgetBuilder waitingBuilder: defaultWaitingBuilder,
          WidgetBuilder activeBuilder,
          WidgetBuilder noneBuilder}) =>
      StreamValueBuilder(
          key, source.valueStream, false, dataBuilder, errorBuilder, waitingBuilder, activeBuilder, noneBuilder);

  factory AsyncValueBuilder.listenable(
          {Key key,
          @required ValueListenable<T> source,
          @required DataWidgetBuilder<T> dataBuilder,
          DataWidgetBuilder<Object> errorBuilder: defaultErrorBuilder,
          WidgetBuilder waitingBuilder: defaultWaitingBuilder,
          WidgetBuilder activeBuilder,
          WidgetBuilder noneBuilder}) =>
      ListenableValueBuilder(key, source, dataBuilder, errorBuilder, waitingBuilder, activeBuilder, noneBuilder);

  AsyncValueBuilder._(
    Key key,
    this.waitForDone,
    this.dataBuilder,
    this.errorBuilder,
    this.waitingBuilder,
    WidgetBuilder activeBuilder,
    WidgetBuilder noneBuilder,
  )   : assert(waitForDone != null),
        assert(dataBuilder != null),
        assert(errorBuilder != null),
        assert(waitingBuilder != null),
        this.activeBuilder = activeBuilder ?? waitingBuilder,
        this.noneBuilder = noneBuilder ?? waitingBuilder,
        super(key: key);

  Widget buildSnapshot(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (!this.waitForDone) {
      final resultWidget = _buildResult(context, snapshot);

      if (resultWidget != null) return resultWidget;
    }

    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return noneBuilder(context);
      case ConnectionState.waiting:
        return waitingBuilder(context);
      case ConnectionState.active:
        return activeBuilder(context);
      case ConnectionState.done:
        return _buildResult(context, snapshot) ?? {throw StateError('ConnectionState.done with no data or error')};
    }

    throw StateError("Flutter Bug: Impossible Connection State");
  }

  Widget _buildResult(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (snapshot.hasError)
      return errorBuilder(context, snapshot.error) ?? {throw StateError('ErrorBuilder returns null')};
    if (snapshot.hasData) return dataBuilder(context, snapshot.data) ?? {throw StateError('DataBuilder returns null')};

    return null;
  }

  static Widget defaultErrorBuilder(BuildContext context, Object error) {
    final errorColor = Theme.of(context).errorColor;

    return Center(
        child: Row(
      children: [
        Icon(Icons.error_outline, color: errorColor),
        Text("Error: ${error.toString()}", style: TextStyle(color: errorColor)),
      ],
    ));
  }

  static Widget defaultWaitingBuilder(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(value: null),
    );
  }
}

class ListenableValueBuilder<T> extends AsyncValueBuilder<T> {
  final ValueListenable<T> listenable;

  ListenableValueBuilder(
    Key key,
    this.listenable,
    DataWidgetBuilder<T> dataBuilder,
    DataWidgetBuilder<Object> errorBuilder,
    WidgetBuilder waitingBuilder,
    WidgetBuilder activeBuilder,
    WidgetBuilder noneBuilder,
  )   : assert(listenable != null),
        super._(key, false, dataBuilder, errorBuilder, waitingBuilder, activeBuilder, noneBuilder);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(valueListenable: listenable, builder: _onValueChanged);

  Widget _onValueChanged(BuildContext context, T value, Widget child) =>
      buildSnapshot(context, AsyncSnapshot.withData(ConnectionState.done, value));
}

class FutureValueBuilder<T> extends AsyncValueBuilder<T> {
  final Future<T> future;

  FutureValueBuilder(
    Key key,
    this.future,
    bool waitForDone,
    DataWidgetBuilder<T> dataBuilder,
    DataWidgetBuilder<Object> errorBuilder,
    WidgetBuilder waitingBuilder,
    WidgetBuilder activeBuilder,
    WidgetBuilder noneBuilder,
  )   : assert(future != null),
        super._(key, waitForDone, dataBuilder, errorBuilder, waitingBuilder, activeBuilder, noneBuilder);

  @override
  Widget build(BuildContext context) => FutureBuilder(future: this.future, builder: buildSnapshot);
}

class StreamValueBuilder<T> extends AsyncValueBuilder<T> {
  final Stream<T> stream;

  StreamValueBuilder(
    Key key,
    this.stream,
    bool waitForDone,
    DataWidgetBuilder<T> dataBuilder,
    DataWidgetBuilder<Object> errorBuilder,
    WidgetBuilder waitingBuilder,
    WidgetBuilder activeBuilder,
    WidgetBuilder noneBuilder,
  )   : assert(stream != null),
        super._(key, waitForDone, dataBuilder, errorBuilder, waitingBuilder, activeBuilder, noneBuilder);

  @override
  Widget build(BuildContext context) => StreamBuilder(stream: this.stream, builder: buildSnapshot);
}
