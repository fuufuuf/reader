import 'package:flutter/material.dart';

typedef void ModeChangedCallback(OverScrollNavigatorMode mode);

class OverScrollNavigator extends StatefulWidget {
  static const double _defaultThreshold = 100;

  final Widget child;
  final bool isLoading;
  final bool isUpEnabled;
  final bool isDownEnabled;
  final double displacementThreshold;
  final ModeChangedCallback onStateChanged;

  const OverScrollNavigator({
    Key key,
    @required this.child,
    @required this.isLoading,
    this.isUpEnabled = true,
    this.isDownEnabled = true,
    this.displacementThreshold = _defaultThreshold,
    @required this.onStateChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OverScrollNavigatorState();
}

enum OverScrollNavigatorMode {
  Loading,
  NoOverScroll,
  UpOverScroll,
  UpArmed,
  DownOverScroll,
  DownArmed
}

class _OverScrollNavigatorState extends State<OverScrollNavigator> {
  double _upDisplacement = 0;
  double _downDisplacement = 0;
  OverScrollNavigatorMode _mode;

  OverScrollNavigatorMode get mode => _mode;

  set mode(OverScrollNavigatorMode value) {
    if (_mode != value) {
      _mode = value;
      widget.onStateChanged(value);
    }
  }

  @override
  void initState() {
    super.initState();
    _mode = OverScrollNavigatorMode.NoOverScroll;
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: _renderUpIndicator(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _renderDownIndicator(),
          ),
          NotificationListener<ScrollNotification>(
              onNotification: _onScrollNotification, child: widget.child)
        ],
      );

  Widget _renderUpIndicator() {
    switch (_mode) {
      case OverScrollNavigatorMode.UpOverScroll:
        return Opacity(
            opacity: _upDisplacement, child: const Icon(Icons.arrow_upward));
      case OverScrollNavigatorMode.UpArmed:
        return Opacity(
            opacity: _upDisplacement,
            child: const Icon(Icons.arrow_upward, size: 30));
      default:
        return null;
    }
  }

  Widget _renderDownIndicator() {
    switch (_mode) {
      case OverScrollNavigatorMode.DownOverScroll:
        return Opacity(
          opacity: _downDisplacement,
          child: const Icon(Icons.arrow_downward),
        );
      case OverScrollNavigatorMode.DownArmed:
        return Opacity(
          opacity: _downDisplacement,
          child: const Icon(Icons.arrow_downward, size: 30),
        );
      default:
        return null;
    }
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (widget.isLoading) {
      setState(() {
        _upDisplacement = 0;
        _downDisplacement = 0;
        mode = OverScrollNavigatorMode.Loading;
      });
      return true;
    }

    final metrics = notification.metrics;

    if (widget.isDownEnabled && metrics.pixels > metrics.maxScrollExtent) {
      setState(() {
        _downDisplacement = _normalizeDisplacement(
            metrics.pixels - metrics.maxScrollExtent,
            widget.displacementThreshold);

        if (_mode != OverScrollNavigatorMode.DownArmed) {
          mode = OverScrollNavigatorMode.DownOverScroll;
        }

        if (_downDisplacement >= 1.0) {
          mode = OverScrollNavigatorMode.DownArmed;
        }
      });
    } else if (widget.isUpEnabled && metrics.pixels < metrics.minScrollExtent) {
      setState(() {
        _upDisplacement = _normalizeDisplacement(
            metrics.minScrollExtent - metrics.pixels,
            widget.displacementThreshold);

        if (_mode != OverScrollNavigatorMode.UpArmed) {
          mode = OverScrollNavigatorMode.UpOverScroll;
        }

        if (_upDisplacement >= 1.0) {
          mode = OverScrollNavigatorMode.UpArmed;
        }
      });
    } else {
      if (_upDisplacement > 0 || _downDisplacement > 0) {
        setState(() {
          _upDisplacement = 0;
          _downDisplacement = 0;
          if (_mode != OverScrollNavigatorMode.UpArmed ||
              _mode != OverScrollNavigatorMode.DownArmed) {
            mode = OverScrollNavigatorMode.NoOverScroll;
          }
        });
      }
    }

    if (notification is ScrollUpdateNotification &&
        notification.dragDetails == null) {
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
      case OverScrollNavigatorMode.DownArmed:
        setState(() {
          mode = OverScrollNavigatorMode.Loading;
        });
        break;
      case OverScrollNavigatorMode.UpArmed:
        setState(() {
          mode = OverScrollNavigatorMode.Loading;
        });
        break;
      default:
        break;
    }
  }

  double _normalizeDisplacement(double value, double threshold) {
    if (value < 0) {
      return 0;
    }

    if (value > threshold) {
      return 1;
    }

    return value / threshold;
  }
}
