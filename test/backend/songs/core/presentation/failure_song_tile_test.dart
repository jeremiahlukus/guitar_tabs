// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:alchemist/alchemist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/songs/core/presentation/failure_song_tile.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/notifiers/favorite_song_notifier.dart';
import 'package:joyful_noise/core/shared/providers.dart';
import '../../../../utils/device.dart';
import '../../../../utils/golden_test_device_scenario.dart';

class MockFavoriteSongNotifier extends Mock implements FavoriteSongNotifier {}

void main() {
  group('FailureSongTile', () {
    testWidgets('contains the error code and error text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FailureSongTile(
              backendFailure: BackendFailure.api(400, 'message'),
            ),
          ),
        ),
      );
      await tester.pump(Duration.zero);

      expect(find.text('An error occurred please retry'), findsOneWidget);
      expect(find.text('API returned: 400'), findsOneWidget);
    });

    testWidgets('when icon button pressed loads new songs', (tester) async {
      final FavoriteSongNotifier mockFavoriteSongNotifier = MockFavoriteSongNotifier();
      when(mockFavoriteSongNotifier.getNextFavoriteSongsPage).thenAnswer((_) => Future.value());
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            favoriteSongsNotifierProvider.overrideWithValue(
              mockFavoriteSongNotifier,
            ),
          ],
          child: const MaterialApp(
            home: FailureSongTile(
              backendFailure: BackendFailure.api(400, 'message'),
            ),
          ),
        ),
      );

      await tester.pump(Duration.zero);
      final getNextFavoriteSongsButton = find.byKey(FailureSongTile.getNextFavoriteSongsButtonKey);
      await tester.tap(getNextFavoriteSongsButton);
      await tester.pumpAndSettle();
      verify(mockFavoriteSongNotifier.getNextFavoriteSongsPage).called(1);
    });
  });

  Widget buildWidgetUnderTest() => const MaterialApp(
        home: Scaffold(
          body: FailureSongTile(
            backendFailure: BackendFailure.api(400, 'message'),
          ),
        ),
      );

  group('FailureTile Golden Test', () {
    goldenTest(
      'renders correctly on mobile',
      fileName: 'FailureTile',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestDeviceScenario(
            device: Device.smallPhone,
            name: 'golden test SongTile on small phone',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            device: Device.tabletLandscape,
            name: 'golden test SongTile on tablet landscape',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            device: Device.tabletPortrait,
            name: 'golden test SongTile on tablet Portrait',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            name: 'golden test SongTile on iphone11',
            builder: buildWidgetUnderTest,
          ),
        ],
      ),
    );
  });
}
