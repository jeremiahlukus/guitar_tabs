import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/main_development.dart' as main_dart;
import 'package:flutter_test/flutter_test.dart';
import 'package:joyful_noise/search/presentation/search_bar.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest(
    'counter state is the same after going to home and switching apps',
    nativeAutomation: true,
    ($) async {
      final originalOnError = FlutterError.onError;
      main_dart.main();
      for (var i = 0; i < 300; i++) {
        await $.pump();
      }
      FlutterError.onError = originalOnError;

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

      expect($(SearchBar), findsOneWidget);
      expect($(PaginatedSongsListView), findsOneWidget);
      await $(#signOutButtonKey).tap();
      for (var i = 0; i < 300; i++) {
        await $.pump();
      }
    },
  );
}
