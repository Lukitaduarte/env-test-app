import 'dart:io';

final class AppEnvironment extends Environment implements AppEnvironmentKeys {
  AppEnvironment._();

  static final AppEnvironment instance = AppEnvironment._();

  @override
  String get env1 => hasEnvironment(
        key: AppEnvironmentKeys.keyEnv1,
        value: const String.fromEnvironment(
          AppEnvironmentKeys.keyEnv1,
        ),
      );

  @override
  int get env2 => hasEnvironment(
        key: AppEnvironmentKeys.keyEnv2,
        value: const int.fromEnvironment(
          AppEnvironmentKeys.keyEnv2,
        ),
      );
}

abstract interface class AppEnvironmentKeys {
  static const keyEnv1 = "ENV_1";
  static const keyEnv2 = "ENV_2";

  String get env1;
  int get env2;
}

abstract class Environment {
  const Environment();

  T hasEnvironment<T>({
    required String key,
    required T value,
  }) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return value;
    }

    if (value == null) {
      throw EnvironmentNotFoundError(
        key: key,
        value: value,
      );
    }

    if (value is String && value.isEmpty) {
      throw EnvironmentNotFoundError(
        key: key,
        value: value,
      );
    }

    if (value is int && value == 0) {
      throw EnvironmentNotFoundError(
        key: key,
        value: value,
      );
    }

    return value;
  }
}

class EnvironmentNotFoundError implements ArgumentError {
  const EnvironmentNotFoundError({
    required this.key,
    this.value,
  });

  final String key;
  final Object? value;

  @override
  String toString() => '''
      key: $key
      value: $value''';

  @override
  Object? get invalidValue => value;

  @override
  String get message => 'Environment variable $key not found!';

  @override
  String? get name => key;

  @override
  StackTrace? get stackTrace => StackTrace.current;
}
