import 'package:flutter/material.dart';

typedef DataWidgetBuilder<T> = Widget Function(BuildContext context, T data);

class AsyncSnapshotRender<T> extends StatelessWidget {
  final AsyncSnapshot<T> snapshot;
  final Future<T> future;
  final Stream<T> stream;

  final bool respectResult;

  final DataWidgetBuilder<T> dataBuilder;
  final DataWidgetBuilder<Object> errorBuilder;

  final WidgetBuilder waitingBuilder;
  final WidgetBuilder activeBuilder;
  final WidgetBuilder noneBuilder;

  AsyncSnapshotRender(
      {Key key,
      this.snapshot,
      this.future,
      this.stream,
      this.respectResult: true,
      @required this.dataBuilder,
      this.errorBuilder: defaultErrorBuilder,
      this.waitingBuilder: defaultWaitingBuilder,
      WidgetBuilder activeBuilder,
      WidgetBuilder noneBuilder})
      : assert((snapshot != null && future == null && stream == null) ||
            (snapshot == null && future != null && stream == null) ||
            (snapshot == null && future == null && stream != null)),
        this.activeBuilder = activeBuilder ?? waitingBuilder,
        this.noneBuilder = noneBuilder ?? waitingBuilder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (future != null) return _renderFuture(future);
    if (stream != null) return _renderStream(stream);
    return _renderSnapshot(context, snapshot);
  }

  Widget _renderFuture(Future<T> future) => FutureBuilder(
        future: future,
        builder: _renderSnapshot,
      );

  Widget _renderStream(Stream<T> stream) => StreamBuilder(stream: stream, builder: _renderSnapshot);

  Widget _renderSnapshot(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (this.respectResult) {
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
