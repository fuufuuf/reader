import 'dart:async';

class SingletonRegistry {
  static final Map<Type, dynamic> _instances = Map();

  static T get<T>() => _instances[T] ?? {throw StateError("$T hasn't been initialized yet")};

  static Future<T> register<T>(FutureOr<T> value) async {
    final instance = await value;

    _instances[T] = instance;

    return instance;
  }
}
