// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// Project imports:
import 'package:joyful_noise/tuner/presentation/tuner_page.dart';

// Create a MockFlutterAudioCapture class
class MockFlutterAudioCapture extends Mock implements FlutterAudioCapture {}

// Create a MockPitchDetector class
class MockPitchDetector extends Mock implements PitchDetector {}

class MockCallbackClass extends Mock implements CallbackClass {}

class CallbackClass {
  void onListen() {}
  void onCancel() {}
}

void main() {
  group('TunerPage', () {
    testWidgets('contains the SfRadialGauge', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TunerPage(),
        ),
      );

      await tester.pumpAndSettle();
      final gauge = find.byType(SfRadialGauge);
      final title = find.text('Guitar Tuner');

      expect(gauge, findsOneWidget);
      expect(title, findsOneWidget);
    });
  });
}
