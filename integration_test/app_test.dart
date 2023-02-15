import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';
import 'package:joyful_noise/main_development.dart' as main_dart;
import 'package:flutter_test/flutter_test.dart';
import 'package:joyful_noise/search/presentation/search_bar.dart';
import 'package:patrol/patrol.dart';

Future<void> restoreFlutterError(Future<void> Function() call) async {
  final originalOnError = FlutterError.onError!;
  await call();
  final overriddenOnError = FlutterError.onError!;

  // restore FlutterError.onError
  FlutterError.onError = (FlutterErrorDetails details) {
    if (overriddenOnError != originalOnError) overriddenOnError(details);
    originalOnError(details);
  };
}

void main() {
  patrolTest(
    'counter state is the same after going to home and switching apps',
    ($) async {
      await restoreFlutterError(() async {
        main_dart.main();
        await $.pumpAndSettle();
      });
      await $.pumpAndSettle();
      await $(#signInButtonKey).tap();
      await $.pumpAndSettle();

      logger.e("-------------------------------");
      await $.native.enterTextByIndex('test@gmail.com', index: 0, appId: 'com.jparrack.joyful-noise.RunnerUITests');
      await $.native.enterTextByIndex('NyanCar', index: 1, appId: 'com.jparrack.joyful-noise.RunnerUITests');
      logger.e('++++++++++++++++++++++++++++++++++++++++++++');
      await $.pump(Duration(seconds: 2));
      await $.native.enterTextByIndex('heyheyhey', index: 1);
      logger.e('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
      await $.pumpAndSettle();
      await $.pump(Duration(seconds: 2));
      await $.native.tap(Selector(text: 'Log in'));
      await $.pumpAndSettle();
      await $.pump(Duration(seconds: 2));
      final finder = find.byType(SearchBar);
      expect(finder, findsOneWidget);
      final findera = find.byType(PaginatedSongsListView);
      expect(findera, findsOneWidget);
    },
    nativeAutomation: true,
  );
}
