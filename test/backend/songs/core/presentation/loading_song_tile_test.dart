// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';

// Project imports:
import 'package:joyful_noise/backend/songs/core/presentation/loading_song_tile.dart';

void main() {
  group('LoadingSongTile', () {
    testWidgets('contains Shimmer, ListTile and CircleAvatar', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingSongTile(),
          ),
        ),
      );
      expect(find.byType(Shimmer), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });
  });
}
