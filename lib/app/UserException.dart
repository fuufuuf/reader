import 'package:flutter/material.dart';
import 'package:timnew_reader/presentations/components/Message.dart';

class UserException implements Exception {
  final String message;

  UserException(this.message);

  String toString() {
    return "錯誤: $message";
  }

  void showAsSnackBar(BuildContext context, {MessageType type: MessageType.Error}) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Message(message, type: type)));
  }

  static Widget renderError(BuildContext context, Object error) {
    final message = error is UserException ? error.message : error.toString();

    return Center(child: Message(message));
  }
}
