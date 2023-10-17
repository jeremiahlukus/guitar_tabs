// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Project imports:
import 'package:joyful_noise/core/infrastructure/provider_logger.dart';

// Flutter imports:

Logger logger = Logger();
Future<void> bootstrap(Widget Function() builder, String envFile) async {
  // ignore: avoid_redundant_argument_values
  await dotenv.load(fileName: envFile);
  var sentryUrl = '';

  if (Platform.isAndroid) {
    sentryUrl = '<android app token>';
  } else if (Platform.isIOS) {
    sentryUrl = dotenv.env['SENTRY_URL']!;
  }
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) async {
    final errorMap = <String, String>{
      'error': details.exceptionAsString(),
      'stackTrace': details.stack.toString(),
    };
    // coverage:ignore-start
    await Sentry.captureException(details, stackTrace: details.stack);
    // coverage:ignore-end
    logger.e(errorMap);
  };
  await runZonedGuarded(
    () async {
      await SentryFlutter.init(
        (options) {
          options
            ..dsn = sentryUrl
            ..tracesSampleRate = 1.0;
        },
        appRunner: () => runApp(
          ProviderScope(observers: [ProviderLogger()], child: builder()),
        ),
      );
    },
    (error, stackTrace) async {
      final errorMap = <String, String>{
        'error': error.toString(),
        'stackTrace': stackTrace.toString(),
      };

      // coverage:ignore-start
      await Sentry.captureException(error, stackTrace: stackTrace);
      // coverage:ignore-end
      logger.e(errorMap);
    },
  );
}
