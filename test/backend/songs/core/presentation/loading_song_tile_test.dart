// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';

// Project imports:
import 'package:joyful_noise/backend/songs/core/presentation/loading_song_tile.dart';

void main() {
  group('LoadingSongTile', () {
    testWidgets('contains Shimmer, ListTile and CircleAvatar', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingSongTile(),
          ),
        ),
      );
      await tester.pump(Duration.zero);
      final shimmerFinder = find.byType(Shimmer);
      final listTileFinder = find.byType(ListTile);
      final circleAvatarFinder = find.byType(CircleAvatar);

      expect(shimmerFinder, findsOneWidget);
      expect(listTileFinder, findsOneWidget);
      expect(circleAvatarFinder, findsOneWidget);
    });
  });
}
