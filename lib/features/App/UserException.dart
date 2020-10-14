import 'package:flutter/material.dart';
import 'package:timnew_reader/widgets/Message.dart';

class UserException implements Exception {
  final String message;

  UserException(this.message);

  String toString() {
    return "錯誤: $message";
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showAsSnackBar(
    BuildContext context, {
    MessageType type: MessageType.Error,
  }) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Message(message, type: type),
      ),
    );
  }

  static Message buildMessageFromError(Object error, {MessageType type: MessageType.Error}) {
    final message = error is UserException ? error.message : error.toString();
    return Message(message, type: type);
  }

  static Widget renderError(BuildContext context, Object error) {
    return Center(
      child: buildMessageFromError(error),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorAsSnackBar(
    BuildContext context,
    Object error, {
    MessageType type: MessageType.Error,
  }) {
    return Scaffold.of(context).showSnackBar(
      SnackBar(
        content: buildMessageFromError(error, type: type),
      ),
    );
  }
}

// ignore: sdk_version_never
Never userError(String message) {
  throw UserException(message);
}

dynamic satisfy(bool assertion) {
  if (!assertion) return null;
  return assertion;
}

extension FutrureUserErrorExtension<T> on Future<T> {
  Future<T> userTimeout(Duration duration, String message) =>
      timeout(duration, onTimeout: () async => userError(message));
}
