// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:newrelic_mobile/config.dart';
import 'package:newrelic_mobile/newrelic_mobile.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// Project imports:
import 'package:joyful_noise/core/infrastructure/provider_logger.dart';

// Flutter imports:

Logger logger = Logger();
Future<void> bootstrap(Widget Function() builder, {String? sentryUrl}) async {
  // ignore: avoid_redundant_argument_values
  await dotenv.load(fileName: '.env');
  var appToken = '';

  if (Platform.isAndroid) {
    appToken = '<android app token>';
  } else if (Platform.isIOS) {
    appToken = dotenv.env['NR_IOS_TOKEN']!;
  }
  WidgetsFlutterBinding.ensureInitialized();
  final config = Config(
    accessToken: appToken,
  );

  FlutterError.onError = (details) {
    final errorMap = <String, String>{
      'error': details.exceptionAsString(),
      'stackTrace': details.stack.toString(),
    };
    // coverage:ignore-start
    NewrelicMobile.instance.recordError(details, details.stack);
    // coverage:ignore-end
    logger.e(errorMap);
  };
  await runZonedGuarded(
    () async {
      await NewrelicMobile.instance.start(config, () {
        runApp(
          ProviderScope(observers: [ProviderLogger()], child: builder()),
        );
      });
    },
    (error, stackTrace) {
      final errorMap = <String, String>{
        'error': error.toString(),
        'stackTrace': stackTrace.toString(),
      };
      // coverage:ignore-start
      NewrelicMobile.instance.recordError(error, stackTrace);
      // coverage:ignore-end
      logger.e(errorMap);
    },
  );
}
