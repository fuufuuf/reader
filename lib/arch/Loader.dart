import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';

typedef FutureOr<T> LoadAction<T>();

abstract class AspectLoader<T> {
  Future<T> initialize();

  Provider<T> buildProvider(T data, Widget child) => Provider.value(
        value: data,
        child: child,
      );
}

abstract class Loader<T> extends StatefulWidget with AspectLoader<T> {
  final Widget child;

  factory Loader.from(LoadAction<T> action, {Key key, Widget child}) => _SimpleLoader(
        key: key,
        child: child,
        loadAction: action,
      );

  static MultiLoader group(Iterable<AspectLoader> aspects, {Key key, Widget child}) =>
      MultiLoader(key: key, aspects: aspects.toList(growable: false), child: child);

  Loader({Key key, this.child}) : super(key: key);

  Widget buildError(BuildContext context, Object error) => DefaultRenders.buildError(context, error);

  Widget buildSplash(BuildContext context) => DefaultRenders.buildWaiting(context);

  @override
  _LoaderState<T> createState() => _LoaderState<T>();
}

class _SimpleLoader<T> extends Loader<T> {
  final LoadAction<T> loadAction;

  _SimpleLoader({Key key, @required this.loadAction, Widget child})
      : assert(loadAction != null),
        super(key: key, child: child);

  @override
  Future<T> initialize() async => await loadAction();
}

class _LoaderState<T> extends State<Loader<T>> with RenderAsyncSnapshot<T> {
  Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.initialize();
  }

  @override
  Widget build(BuildContext context) => buildFuture(_future);

  Widget buildError(BuildContext context, Object error) => widget.buildError(context, error);

  Widget buildWaiting(BuildContext context) => widget.buildSplash(context);

  @override
  Widget buildData(BuildContext context, T data) => widget.buildProvider(data, widget.child);
}

class MultiLoader extends StatefulWidget {
  final Widget child;
  final List<AspectLoader> aspects;

  MultiLoader({Key key, this.aspects, this.child}) : super(key: key);

  Widget buildError(BuildContext context, Object error) => DefaultRenders.buildError(context, error);

  Widget buildSplash(BuildContext context) => DefaultRenders.buildWaiting(context);

  @override
  _MultiLoaderState createState() => _MultiLoaderState();
}

class _MultiLoaderState extends State<MultiLoader> with RenderAsyncSnapshot<List<Provider>> {
  Future<List<Provider>> _future;

  @override
  void initState() {
    super.initState();

    _future = Future.wait(widget.aspects.map((e) => _buildProvider(e)), eagerError: true);
  }

  Future<Provider> _buildProvider(AspectLoader aspect) async {
    final value = await aspect.initialize();
    return aspect.buildProvider(value, null);
  }

  @override
  Widget build(BuildContext context) => buildFuture(_future);

  Widget buildError(BuildContext context, Object error) => widget.buildError(context, error);

  Widget buildWaiting(BuildContext context) => widget.buildSplash(context);

  @override
  Widget buildData(BuildContext context, List<Provider> providers) =>
      MultiProvider(providers: providers, child: widget.child);
}
