import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:timnew_reader/widgets/IndexedTrackingScrollController.dart';

class OverscrollDetector extends StatefulWidget {
  static const double _defaultThreshold = 100;

  final Widget child;
  final IndexedTrackingScrollController scrollController;
  final bool allowUpwardOverscroll;
  final bool allowDownwardOverscroll;
  final double displacementThreshold;
  final VoidCallback onUpwardNavigate;
  final VoidCallback onDownwardNavigate;

  const OverscrollDetector({
    Key key,
    @required this.child,
    @required this.scrollController,
    this.allowUpwardOverscroll = true,
    this.allowDownwardOverscroll = true,
    this.onUpwardNavigate,
    this.onDownwardNavigate,
    this.displacementThreshold = _defaultThreshold,
  })  : assert(child != null),
        assert(!(allowUpwardOverscroll && onUpwardNavigate == null)),
        assert(!(allowDownwardOverscroll && onDownwardNavigate == null)),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _OverscrollDetectorState();
}

enum _Mode { AutoScrolling, Normal, Up, UpArmed, Down, DownArmed }

class _OverscrollDetectorState extends State<OverscrollDetector> {
  double _upDisplacement = 0;
  double _downDisplacement = 0;

  _Mode _mode;

  _Mode get mode => _mode;

  set mode(_Mode value) {
    if (_mode != value) {
      _mode = value;
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrintBeginFrameBanner = true;
    debugPrintEndFrameBanner = true;

    _mode = _Mode.Normal;
    widget.scrollController.addListener(_onScrollNotification);
  }

  @override
  void didUpdateWidget(OverscrollDetector oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController.removeListener(_onScrollNotification);
      widget.scrollController.addListener(_onScrollNotification);
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScrollNotification);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final upIndicator = _renderUpIndicator();
    final downIndicator = _renderDownIndicator();

    return Stack(
      fit: StackFit.expand,
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        if (upIndicator != null) upIndicator,
        if (downIndicator != null) downIndicator,
        widget.child,
      ],
    );
  }

  Widget _renderUpIndicator() {
    switch (_mode) {
      case _Mode.Up:
      case _Mode.UpArmed:
        return Align(
          alignment: Alignment.topCenter,
          child: _OverScrollIndicator(
            direction: _Direction.Up,
            opacity: _upDisplacement,
            isArmed: _mode == _Mode.UpArmed,
          ),
        );
      default:
        return null;
    }
  }

  Widget _renderDownIndicator() {
    switch (_mode) {
      case _Mode.Down:
      case _Mode.DownArmed:
        return Align(
          alignment: Alignment.bottomCenter,
          child: _OverScrollIndicator(
            direction: _Direction.Down,
            opacity: _downDisplacement,
            isArmed: _mode == _Mode.DownArmed,
          ),
        );
      default:
        return null;
    }
  }

  void _onScrollNotification() {
    debugPrint("OverscrollDetector: $_mode, ${widget.scrollController.isAutoScrolling}");

    if (_mode != _Mode.AutoScrolling && widget.scrollController.isAutoScrolling) {
      debugPrint("OverscrollDetector: Begin AutoScrolling");
      _mode = _Mode.AutoScrolling;
      return;
    }

    if (_mode == _Mode.AutoScrolling) {
      if (!widget.scrollController.isAutoScrolling) {
        debugPrint("OverscrollDetector: End AutoScrolling");
        print(widget.scrollController.position);

        _mode = _Mode.Normal;
      } else {
        print("OverscrollDetector: Skip due to AutoScrolling");
        return;
      }
    }

    final position = widget.scrollController.position;

    if (widget.allowDownwardOverscroll && position.pixels > position.maxScrollExtent) {
      setState(() {
        _downDisplacement =
            _normalizeDisplacement(position.pixels - position.maxScrollExtent, widget.displacementThreshold);

        if (_mode != _Mode.DownArmed) {
          debugPrint("OverscrollDetector: Down");
          mode = _Mode.Down;
        }

        if (_downDisplacement >= 1.0) {
          debugPrint("OverscrollDetector: Down Armed");
          debugPrint("$position}");

          mode = _Mode.DownArmed;
        }
      });
    } else if (widget.allowUpwardOverscroll && position.pixels < position.minScrollExtent) {
      setState(() {
        _upDisplacement =
            _normalizeDisplacement(position.minScrollExtent - position.pixels, widget.displacementThreshold);

        if (_mode != _Mode.UpArmed) {
          debugPrint("OverscrollDetector: Up");
          mode = _Mode.Up;
        }

        if (_upDisplacement >= 1.0) {
          debugPrint("OverscrollDetector: Up Armed");
          mode = _Mode.UpArmed;
        }
      });
    } else {
      if (_upDisplacement > 0 || _downDisplacement > 0) {
        setState(() {
          _upDisplacement = 0;
          _downDisplacement = 0;
          if (_mode != _Mode.UpArmed || _mode != _Mode.DownArmed) {
            debugPrint("OverscrollDetector: Return Normal");

            mode = _Mode.Normal;
          }
        });
      }
    }

    switch (_mode) {
      case _Mode.DownArmed:
        setState(() {
          debugPrint("OverscrollDetector: Down Fired");
          mode = _Mode.Normal;
          widget.onDownwardNavigate();
        });
        break;
      case _Mode.UpArmed:
        setState(() {
          debugPrint("OverscrollDetector: Up Fired");
          mode = _Mode.Normal;
          widget.onUpwardNavigate();
        });
        break;
      default:
        break;
    }
  }

  double _normalizeDisplacement(double value, double threshold) {
    if (value < 0) return 0;

    if (value > threshold) return 1;

    return value / threshold;
  }
}

enum _Direction { Up, Down }

class _OverScrollIndicator extends StatelessWidget {
  final double opacity;
  final _Direction direction;
  final bool isArmed;

  const _OverScrollIndicator({Key key, @required this.direction, this.opacity: 1, this.isArmed: false})
      : assert(direction != null),
        assert(opacity >= 0 && opacity <= 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Icon(
        direction == _Direction.Up ? Icons.arrow_upward : Icons.arrow_downward,
        size: isArmed ? 30 : null,
      ),
    );
  }
}
