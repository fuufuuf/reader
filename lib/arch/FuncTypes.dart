import 'package:flutter/widgets.dart';

typedef T ValueUpdater<T>(T current);
typedef Future<T> AsyncValueUpdater<T>(T current);
typedef T ErrorFixer<T>(Object error);
typedef DataWidgetBuilder<T> = Widget Function(BuildContext context, T data);
