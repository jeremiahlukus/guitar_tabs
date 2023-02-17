import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joyful_noise/auth/shared/providers.dart';
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
      // await restoreFlutterError(() async {
      //   main_dart.main();
      // });
      main_dart.main();
      for (var i = 0; i < 300; i++) {
        await $.pump();
      }

      await $(#signInButtonKey).tap();
      for (var i = 0; i < 300; i++) {
        await $.pump();
      }
      await $.native.enterTextByIndex(
        'hey@hey.com',
        index: 0,
      );
      await $.native.enterTextByIndex(
        'heyheyhey',
        index: 1,
      );

      await $.native.tap(Selector(text: 'Sign in'));

      for (var i = 0; i < 300; i++) {
        await $.pump();
      }
      //final finder = find.byType(SearchBar);
      expect($(SearchBar), findsOneWidget);
      expect($(SearchBar), findsNothing);
      // expect(finder, findsOneWidget);
      // final findera = find.byType(PaginatedSongsListView);
      // expect(findera, findsNothing);
      await $(#signOutButtonKey).tap();
      for (var i = 0; i < 300; i++) {
        await $.pump();
      }
    },
    nativeAutomation: true,
  );
}
