import 'package:flutter/widgets.dart';

class ApplyTextColor extends StatelessWidget {
  final Color textColor;
  final Widget child;

  const ApplyTextColor({Key key, @required this.textColor, this.child})
      : assert(textColor != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: TextStyle(color: textColor),
      child: IconTheme.merge(
        data: IconThemeData(color: textColor),
        child: child,
      ),
    );
  }
}
