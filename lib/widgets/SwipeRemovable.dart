import 'package:flutter/material.dart';

class SwipeRemovable extends StatelessWidget {
  final Widget child;
  final VoidCallback onRemoved;

  SwipeRemovable({
    @required Key key,
    @required this.child,
    @required this.onRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: key,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16),
          child: const Text('滑动删除', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (DismissDirection direction) => onRemoved(),
        dismissThresholds: const {DismissDirection.endToStart: .7},
        child: child,
      );
}
