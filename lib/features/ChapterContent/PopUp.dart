import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/features/Theme/AppTheme.dart';
import 'package:timnew_reader/features/Theme/ApplyTextColor.dart';

class PopUpContainer extends StatelessWidget {
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final Widget child;
  final ShapeBorder shape;

  PopUpContainer({
    Key key,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0))),
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final edgeInsets = MediaQuery.of(context).viewInsets + EdgeInsets.symmetric(horizontal: 140, vertical: 210);

    var readingThemeData = context.watch<AppTheme>().readingThemeData;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: edgeInsets.horizontal, height: edgeInsets.vertical),
        child: Material(
          elevation: 24.0,
          color: readingThemeData.popUpBackgroundColor,
          type: MaterialType.card,
          shape: shape,
          child: ApplyTextColor(
            textColor: readingThemeData.popUpTextColor,
            child: child,
          ),
        ),
      ),
    );
  }
}

class PopUpButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final GestureTapCallback onTap;

  const PopUpButton({Key key, this.text, this.enabled = true, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: enabled ? onTap : null,
        child: Container(
          alignment: Alignment.center,
          decoration: _buildDecoration(context),
          child: Text(text),
        ),
      );

  Decoration _buildDecoration(BuildContext context) => BoxDecoration(
        border: Border.all(
          color: context.watch<AppTheme>().readingThemeData.popUpTextColor,
          width: 1,
        ),
      );
}

class PopUpPicker<T> extends StatelessWidget {
  final List<String> options;
  final List<T> values;
  final int selectedIndex;
  final Function(T) onValueChanged;

  PopUpPicker({
    Key key,
    @required this.options,
    @required this.values,
    int defaultIndex,
    T value,
    this.onValueChanged,
  })  : assert(options != null),
        assert(values != null),
        selectedIndex = _findValueIndex(values, value, defaultIndex),
        super(key: key);

  static int _findValueIndex<T>(List<T> values, T value, int defaultIndex) {
    var index = values.indexOf(value);
    return index == -1 ? defaultIndex : index;
  }

  Decoration _renderDecoration(BuildContext context) =>
      BoxDecoration(border: Border.all(color: context.watch<AppTheme>().readingThemeData.popUpTextColor, width: 1));

  @override
  Widget build(BuildContext context) => Container(
      alignment: Alignment.center,
      decoration: _renderDecoration(context),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
        InkWell(
          onTap: _buildOnIncrease(),
          child: Padding(padding: EdgeInsets.all(16), child: Icon(Icons.add)),
        ),
        Text(options[selectedIndex]),
        InkWell(
          onTap: _renderOnDecrease(),
          child: Container(padding: EdgeInsets.all(16), child: Icon(Icons.remove)),
        ),
      ]));

  GestureTapCallback _buildOnIncrease() => selectedIndex < options.length - 1
      ? () {
          _onIndexChanged(selectedIndex + 1);
        }
      : null;

  GestureTapCallback _renderOnDecrease() => selectedIndex > 0
      ? () {
          _onIndexChanged(selectedIndex - 1);
        }
      : null;

  void _onIndexChanged(int newIndex) {
    if (onValueChanged != null) {
      onValueChanged(values[newIndex]);
    }
  }
}
