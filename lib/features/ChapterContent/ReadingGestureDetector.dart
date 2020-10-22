import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/features/App/common.dart';
import 'package:timnew_reader/features/Theme/AppTheme.dart';

typedef void ReadingControlTapCallback(TapSection section);

class ReadingGestureDetector extends StatefulWidget {
  final GestureTapCallback onPageUp;
  final GestureTapCallback onPageDown;
  final GestureTapCallback onControlPanel;
  final double pagingAreaSizePercentage;
  final Widget child;

  const ReadingGestureDetector(
      {Key key, this.pagingAreaSizePercentage: 0.3, this.onPageUp, this.onPageDown, this.onControlPanel, this.child})
      : assert(child != null),
        assert(pagingAreaSizePercentage != null, "pagingAreaSizePercentage can't be null"),
        assert(pagingAreaSizePercentage >= 0 && pagingAreaSizePercentage < 0.5),
        super(key: key);

  @override
  _ReadingGestureDetectorState createState() => _ReadingGestureDetectorState();
}

class _ReadingGestureDetectorState extends State<ReadingGestureDetector> {
  bool _isAreaGuideVisible = false;

  @override
  Widget build(BuildContext context) => _isAreaGuideVisible ? _buildAreaGuide(context) : _buildGestureDetector();

  Widget _buildGestureDetector() => GestureDetector(
        onLongPress: null, //showAreaGuide,
        onDoubleTapDown: _onDoubleTapDown,
        onDoubleTap: _onDoubleTap,
        child: widget.child,
      );

  Offset _doubleTapLocalOffset;

  void _onDoubleTapDown(TapDownDetails details) {
    _doubleTapLocalOffset = details.globalPosition;
  }

  void _onDoubleTap() {
    final renderBox = context.findRenderObject() as RenderBox;
    final height = renderBox.size.height;
    final pagingAreaHeight = height * widget.pagingAreaSizePercentage;

    if (_doubleTapLocalOffset.dy <= pagingAreaHeight) {
      widget.onPageUp.invokeIfNotNull();
    } else if (_doubleTapLocalOffset.dy >= height - pagingAreaHeight) {
      widget.onPageDown.invokeIfNotNull();
    } else {
      widget.onControlPanel.invokeIfNotNull();
    }
  }

  Widget _buildAreaGuide(BuildContext context) {
    final appTheme = context.watch<AppTheme>();

    final backgroundColor = appTheme.palette.controlPanelBackgroundColor;
    final foregroundColor = appTheme.palette.controlPanelForegroundColor;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        widget.child,
        GestureDetector(
          onTap: dismissAreaGuide,
          child: Container(
            color: backgroundColor,
            child: DefaultTextStyle(
              style: TextStyle(color: foregroundColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    flex: _percentageToFlex(widget.pagingAreaSizePercentage),
                    child: const Center(child: Text("雙擊向上翻頁")),
                  ),
                  Flexible(
                    flex: _percentageToFlex(1 - 2 * widget.pagingAreaSizePercentage),
                    child: Container(
                      alignment: Alignment.center,
                      decoration:
                          BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: foregroundColor))),
                      child: const Text("雙擊顯示控制面板"),
                    ),
                  ),
                  Flexible(
                    flex: _percentageToFlex(widget.pagingAreaSizePercentage),
                    child: const Center(child: Text("雙擊向下翻頁")),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  int _percentageToFlex(double percentage) => (percentage * 100).toInt();

  void showAreaGuide() {
    setState(() {
      _isAreaGuideVisible = true;
    });
  }

  void dismissAreaGuide() {
    setState(() {
      _isAreaGuideVisible = false;
    });
  }
}

enum TapSection { PageUp, ControlPanel, PageDown }
