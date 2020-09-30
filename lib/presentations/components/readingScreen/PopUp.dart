import 'package:flutter/material.dart';
import 'package:timnew_reader/presentations/wrappers/ReadingThemeProvider.dart';

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
    final theme = ReadingThemeProvider.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: edgeInsets.horizontal, height: edgeInsets.vertical),
        child: Material(
            elevation: 24.0,
            color: theme.popUpBackgroundColor,
            type: MaterialType.card,
            shape: shape,
            child: DefaultTextStyle(
                style: theme.popUpMenuTextStyle, child: IconTheme.merge(data: theme.popUpMenuIconStyle, child: child))),
      ),
    );
  }
}

class PopUpButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final GestureTapCallback onTap;

  const PopUpButton({Key key, this.text, this.enabled = true, this.onTap}) : super(key: key);

  Decoration _renderDecoration(BuildContext context) =>
      BoxDecoration(border: Border.all(color: ReadingThemeProvider.of(context).popUpTextColor, width: 1));

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: enabled ? onTap : null,
        child: Container(
          alignment: Alignment.center,
          decoration: _renderDecoration(context),
          child: Text(text),
        ),
      );
}

class PopUpPicker<T> extends StatelessWidget {
  final List<String> options;
  final List<T> values;
  final ValueNotifier<int> selectedIndex;
  final ValueNotifier<T> selectedValue;

  PopUpPicker(
      {Key key,
      @required this.options,
      @required this.values,
      @required this.selectedIndex,
      @required this.selectedValue})
      : assert(options != null),
        assert(values != null),
        assert(selectedIndex != null),
        assert(selectedValue != null),
        super(key: key);

  PopUpPicker.fromValue(
      {Key key, List<String> options, List<T> values, ValueNotifier<T> selectedValue, int defaultIndex})
      : this(
            key: key,
            options: options,
            values: values,
            selectedValue: selectedValue,
            selectedIndex: ValueNotifier<int>(_findValueIndex(values, selectedValue.value, defaultIndex)));

  static int _findValueIndex<T>(List<T> values, T value, int defaultIndex) {
    var index = values.indexOf(value);
    return index == -1 ? defaultIndex : index;
  }

  String get _currentOption => options[selectedIndex.value];

  T get _currentValue => values[selectedIndex.value];

  Decoration _renderDecoration(BuildContext context) =>
      BoxDecoration(border: Border.all(color: ReadingThemeProvider.of(context).popUpTextColor, width: 1));

  @override
  Widget build(BuildContext context) => Container(
      alignment: Alignment.center,
      decoration: _renderDecoration(context),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
        InkWell(
          onTap: _renderOnIncrease(),
          child: Padding(padding: EdgeInsets.all(16), child: Icon(Icons.add)),
        ),
        Text(_currentOption),
        InkWell(
          onTap: _renderOnDecrease(),
          child: Container(padding: EdgeInsets.all(16), child: Icon(Icons.remove)),
        ),
      ]));

  GestureTapCallback _renderOnIncrease() => selectedIndex.value < options.length - 1
      ? () {
          selectedIndex.value = selectedIndex.value + 1;
          selectedValue.value = _currentValue;
        }
      : null;

  GestureTapCallback _renderOnDecrease() => selectedIndex.value > 0
      ? () {
          selectedIndex.value = selectedIndex.value - 1;
          selectedValue.value = _currentValue;
        }
      : null;
}
