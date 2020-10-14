import 'package:flutter/widgets.dart';

class DefaultTextIconColor extends StatelessWidget {
  final Color color;
  final Widget child;

  const DefaultTextIconColor({Key key, this.color, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTextStyle(
        style: TextStyle(color: color),
        child: IconTheme(
          data: IconThemeData(color: color),
          child: child,
        ),
      );
}
