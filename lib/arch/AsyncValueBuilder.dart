import 'package:flutter/material.dart';
import 'Request.dart';

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
          @required Future<T> future,
          bool waitForDone: false,
          @required DataWidgetBuilder<T> dataBuilder,
          DataWidgetBuilder<Object> errorBuilder: defaultErrorBuilder,
          WidgetBuilder waitingBuilder: defaultWaitingBuilder,
          WidgetBuilder activeBuilder,
          WidgetBuilder noneBuilder}) =>
      FutureValueBuilder(
          key, future, waitForDone, dataBuilder, errorBuilder, waitingBuilder, activeBuilder, noneBuilder);

  factory AsyncValueBuilder.stream(
          {Key key,
          @required Stream<T> stream,
          bool waitForDone: false,
          @required DataWidgetBuilder<T> dataBuilder,
          DataWidgetBuilder<Object> errorBuilder: defaultErrorBuilder,
          WidgetBuilder waitingBuilder: defaultWaitingBuilder,
          WidgetBuilder activeBuilder,
          WidgetBuilder noneBuilder}) =>
      StreamValueBuilder(
          key, stream, waitForDone, dataBuilder, errorBuilder, waitingBuilder, activeBuilder, noneBuilder);

  factory AsyncValueBuilder.request(
          {Key key,
          @required Request<T> request,
          @required DataWidgetBuilder<T> dataBuilder,
          DataWidgetBuilder<Object> errorBuilder: defaultErrorBuilder,
          WidgetBuilder waitingBuilder: defaultWaitingBuilder,
          WidgetBuilder activeBuilder,
          WidgetBuilder noneBuilder}) =>
      StreamValueBuilder(
          key, request.resultStream, false, dataBuilder, errorBuilder, waitingBuilder, activeBuilder, noneBuilder);

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
        return _buildResult(context, snapshot) ??
            defaultErrorBuilder(context, "Flutter Bug: ConnectionState.done with neither data or error");
    }

    return defaultErrorBuilder(context, "Flutter Bug: Impossible Connection State");
  }

  Widget _buildResult(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (snapshot.hasError)
      return errorBuilder(context, snapshot.error) ?? defaultErrorBuilder(context, "Error Render returns null");
    if (snapshot.hasData)
      return dataBuilder(context, snapshot.data) ?? defaultErrorBuilder(context, "Data Render returns null");

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
