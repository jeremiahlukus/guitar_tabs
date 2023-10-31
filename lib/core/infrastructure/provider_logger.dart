// Dart imports:
import 'dart:io';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Project imports:
import 'package:joyful_noise/core/presentation/bootstrap.dart' as bootstrap;

class ProviderLogger extends ProviderObserver {
  ProviderLogger({this.loggerInstance}) {
    loggerInstance ??= bootstrap.logger;
  }

  Logger? loggerInstance;

  @override
  Future<void> providerDidFail(
    ProviderBase<dynamic> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) async {
    final errorMap = <String, String>{
      'error': error.toString(),
      'stackTrace': stackTrace.toString(),
    };
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      // coverage:ignore-start
      await Sentry.captureException(error, stackTrace: stackTrace);
      // coverage:ignore-end
    }
    loggerInstance?.e(errorMap);
  }

  @override
  Future<void> didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) async {
    final loggerMessage = {
      'didUpdateProvider': {
        'type': provider.runtimeType,
        'new_value': newValue.toString(),
        'old_value': previousValue.toString(),
      },
    };
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      // coverage:ignore-start
      // NewrelicMobile.instance.redirectDebugPrint();
      // coverage:ignore-end
    }

    loggerInstance?.i(loggerMessage);
  }
}
