import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final MessageType type;
  final String content;
  final bool textColor;
  final bool iconColor;

  const Message(this.content, {Key key, this.type: MessageType.Error, this.textColor: true, this.iconColor: true})
      : assert(content != null),
        assert(type != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == MessageType.Message) {
      return _text();
    }

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: _icon(),
        ),
        _text(),
      ],
    );
  }

  Widget _icon() => Icon(
        _iconData(),
        color: _iconColor(),
      );

  Widget _text() => Text(
        content,
        style: TextStyle(color: _textColor()),
      );

  IconData _iconData() {
    switch (type) {
      case MessageType.Info:
        return Icons.info_outline;
      case MessageType.Success:
        return Icons.check;
      case MessageType.Warning:
        return Icons.warning_amber_outlined;
      case MessageType.Error:
        return Icons.error_outline;
      default:
        return null;
    }
  }

  Color _iconColor() {
    switch (type) {
      case MessageType.Info:
        return Colors.blueAccent.shade400;
      case MessageType.Success:
        return Colors.greenAccent.shade400;
      case MessageType.Warning:
        return Colors.yellowAccent.shade400;
      case MessageType.Error:
        return Colors.redAccent.shade400;
      default:
        return null;
    }
  }

  _textColor() {
    if (!textColor) return null;

    switch (type) {
      case MessageType.Info:
        return Colors.blueAccent;
      case MessageType.Success:
        return Colors.greenAccent;
      case MessageType.Warning:
        return Colors.yellowAccent;
      case MessageType.Error:
        return Colors.redAccent;
      default:
        return null;
    }
  }
}

enum MessageType { Message, Info, Success, Warning, Error }
