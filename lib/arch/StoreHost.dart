import 'package:flutter/material.dart';
import 'Store.dart';

typedef bool StoreConfigChangeChecker<TS extends Store>(TS current, TS old);

abstract class StoreHost<T, TS extends Store<T>> extends StatelessWidget {
  final TS request;

  StoreHost(this.request);

  @override
  Widget build(BuildContext context) => StoreProvider(request, buildChild(), checkRequestChanged);

  Widget buildChild();

  bool checkRequestChanged(TS current, TS old) => current != old;
}

class StoreProvider<TS extends Store> extends InheritedWidget {
  final TS request;

  final StoreConfigChangeChecker changeChecker;

  const StoreProvider(this.request, Widget child, this.changeChecker)
      : assert(request != null),
        assert(child != null),
        assert(changeChecker != null),
        super(child: child);

  @override
  bool updateShouldNotify(StoreProvider old) => changeChecker(request, old.request);
}
