import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/arch/AsyncValueBuilder.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';

class Initializer<T> extends StatelessWidget with RenderAsyncSnapshot<T> {
  final WidgetBuilder builder;
  final WidgetBuilder splashBuilder;
  final DataWidgetBuilder<Object> errorBuilder;
  final Future<T> runtimeFuture;

  const Initializer({Key key, this.runtimeFuture, this.builder, this.splashBuilder, this.errorBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) => buildFuture(runtimeFuture);

  @override
  Widget buildBusy(BuildContext context) => splashBuilder(context);

  @override
  Widget buildError(BuildContext context, Object error) => errorBuilder(context, error);

  @override
  Widget buildData(BuildContext context, T data) {
    return Provider.value(
      value: data,
      child: Builder(
        builder: builder,
      ),
    );
  }
}
