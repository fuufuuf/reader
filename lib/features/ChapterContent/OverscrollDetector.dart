import 'package:flutter/material.dart';

class OverscrollDetector extends StatefulWidget {
  static const double _defaultThreshold = 100;

  final Widget child;
  final bool allowUpwardOverscroll;
  final bool allowDownwardOverscroll;
  final double displacementThreshold;
  final VoidCallback onUpwardNavigate;
  final VoidCallback onDownwardNavigate;

  const OverscrollDetector({
    Key key,
    @required this.child,
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

enum _Mode { Loading, Normal, UpOver, UpArmed, Down, DownArmed }

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
    _mode = _Mode.Normal;
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
        NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: widget.child,
        )
      ],
    );
  }

  Widget _renderUpIndicator() {
    switch (_mode) {
      case _Mode.UpOver:
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

  bool _onScrollNotification(ScrollNotification notification) {
    final metrics = notification.metrics;

    if (widget.allowDownwardOverscroll && metrics.pixels > metrics.maxScrollExtent) {
      setState(() {
        _downDisplacement =
            _normalizeDisplacement(metrics.pixels - metrics.maxScrollExtent, widget.displacementThreshold);

        if (_mode != _Mode.DownArmed) {
          mode = _Mode.Down;
        }

        if (_downDisplacement >= 1.0) mode = _Mode.DownArmed;
      });
    } else if (widget.allowUpwardOverscroll && metrics.pixels < metrics.minScrollExtent) {
      setState(() {
        _upDisplacement =
            _normalizeDisplacement(metrics.minScrollExtent - metrics.pixels, widget.displacementThreshold);

        if (_mode != _Mode.UpArmed) {
          mode = _Mode.UpOver;
        }

        if (_upDisplacement >= 1.0) {
          mode = _Mode.UpArmed;
        }
      });
    } else {
      if (_upDisplacement > 0 || _downDisplacement > 0) {
        setState(() {
          _upDisplacement = 0;
          _downDisplacement = 0;
          if (_mode != _Mode.UpArmed || _mode != _Mode.DownArmed) {
            mode = _Mode.Normal;
          }
        });
      }
    }

    if (notification is ScrollUpdateNotification && notification.dragDetails == null) {
      _tryFire();
      return true;
    }

    if (notification is ScrollEndNotification) {
      _tryFire();
      return true;
    }

    return true;
  }

  void _tryFire() {
    switch (_mode) {
      case _Mode.DownArmed:
        setState(() {
          mode = _Mode.Loading;
          widget.onDownwardNavigate();
        });
        break;
      case _Mode.UpArmed:
        setState(() {
          mode = _Mode.Loading;
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
