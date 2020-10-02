import 'package:flutter/material.dart';
import 'Request.dart';

typedef bool RequestChangeChecker<TR extends Request>(TR current, TR old);

abstract class RequestHost<T, TR extends Request<T>> extends StatelessWidget {
  final TR request;

  RequestHost(this.request);

  @override
  Widget build(BuildContext context) => RequestProvider(request, buildChild(), checkRequestChanged);

  Widget buildChild();

  bool checkRequestChanged(TR current, TR old) => current != old;
}

class RequestProvider<TR extends Request> extends InheritedWidget {
  final TR request;

  final RequestChangeChecker changeChecker;

  const RequestProvider(this.request, Widget child, this.changeChecker)
      : assert(request != null),
        assert(child != null),
        assert(changeChecker != null),
        super(child: child);

  @override
  bool updateShouldNotify(RequestProvider old) => changeChecker(request, old.request);
}
