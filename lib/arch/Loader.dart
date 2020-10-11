import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';

typedef FutureOr<T> LoadAction<T>();

abstract class AspectLoader<T> {
  Future<T> initialize();

  InheritedProvider<T> buildProvider({@required T data, TransitionBuilder builder, Widget child}) => Provider.value(
        value: data,
        builder: builder,
        child: child,
      );

  factory AspectLoader.wrap(InheritedProvider<T> provider) => _ProviderAspectLoaderWrapper(provider);
}

class _ProviderAspectLoaderWrapper<T> implements AspectLoader<T> {
  final InheritedProvider<T> provider;

  _ProviderAspectLoaderWrapper(this.provider);

  @override
  InheritedProvider<T> buildProvider({T data, TransitionBuilder builder, Widget child}) {
    return provider;
  }

  @override
  Future<T> initialize() => Future.value(null);
}

abstract class Loader<T> extends StatefulWidget with AspectLoader<T> {
  factory Loader.from(LoadAction<T> action, {Key key, TransitionBuilder builder, Widget child}) => _SimpleLoader(
        key: key,
        loadAction: action,
        builder: builder,
        child: child,
      );

  static MultiLoader multi(List<AspectLoader> aspects, {Key key, TransitionBuilder builder, Widget child}) =>
      MultiLoader(
        key: key,
        aspects: aspects,
        builder: builder,
        child: child,
      );

  final Widget child;
  final TransitionBuilder builder;

  Loader({Key key, this.builder, this.child}) : super(key: key);

  Widget buildError(BuildContext context, Object error) => DefaultRenders.buildError(context, error);

  Widget buildSplash(BuildContext context) => DefaultRenders.buildWaiting(context);

  @override
  _LoaderState<T> createState() => _LoaderState<T>();
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
  Widget buildData(BuildContext context, T data) => widget.buildProvider(
        data: data,
        builder: widget.builder,
        child: widget.child,
      );
}

class _SimpleLoader<T> extends Loader<T> {
  final LoadAction<T> loadAction;

  _SimpleLoader({Key key, @required this.loadAction, TransitionBuilder builder, Widget child})
      : assert(loadAction != null),
        super(key: key, builder: builder, child: child);

  @override
  Future<T> initialize() async => await loadAction();
}

class MultiLoader extends StatefulWidget {
  final List<AspectLoader> aspects;
  final Widget child;
  final TransitionBuilder builder;

  MultiLoader({Key key, this.aspects, this.child, this.builder}) : super(key: key);

  Widget buildError(BuildContext context, Object error) => DefaultRenders.buildError(context, error);

  Widget buildSplash(BuildContext context) => DefaultRenders.buildWaiting(context);

  @override
  _MultiLoaderState createState() => _MultiLoaderState();
}

class _MultiLoaderState extends State<MultiLoader> with RenderAsyncSnapshot<List<InheritedProvider>> {
  Future<List<InheritedProvider>> _future;

  @override
  void initState() {
    super.initState();

    _future = Future.wait(widget.aspects.map((e) => _buildProvider(e)), eagerError: true);
  }

  Future<Provider> _buildProvider(AspectLoader aspect) async {
    final value = await aspect.initialize();
    return aspect.buildProvider(data: value);
  }

  @override
  Widget build(BuildContext context) => buildFuture(_future);

  Widget buildError(BuildContext context, Object error) => widget.buildError(context, error);

  Widget buildWaiting(BuildContext context) => widget.buildSplash(context);

  @override
  Widget buildData(BuildContext context, List<InheritedProvider> providers) => MultiProvider(
        providers: providers,
        child: widget.child,
        builder: widget.builder,
      );
}
