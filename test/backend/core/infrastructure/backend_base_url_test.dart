// Dart imports:

// Flutter imports:

// Dart imports:
import 'dart:io';

// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:platform/platform.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:joyful_noise/backend/core/infrastructure/backend_base_url.dart';

void main() {
  dotenv.testLoad(fileInput: File('.env').readAsStringSync());
  group('.backendUrl', () {
    group('When in debug mode', () {
      tearDown(() {
        BackendConstants.platform = null;
      });

      test('returns the value of BackendConstants().backendBaseUrl when IOS', () async {
        BackendConstants.isDebugMode = true;
        BackendConstants.platform = FakePlatform(operatingSystem: Platform.iOS);

        final actualAuthorizationUrl = BackendConstants().backendBaseUrl();
        const expectedAuthorizationUrl = '127.0.0.1:8888';

        expect(actualAuthorizationUrl, expectedAuthorizationUrl);
      });
      test('returns the value of BackendConstants().backendBaseUrl when Android', () async {
        BackendConstants.isDebugMode = true;
        BackendConstants.platform = FakePlatform(operatingSystem: Platform.android);

        final actualAuthorizationUrl = BackendConstants().backendBaseUrl();
        const expectedAuthorizationUrl = '10.0.2.2:8888';

        expect(actualAuthorizationUrl, expectedAuthorizationUrl);
      });
    });

    test('returns the value of BackendConstants().backendBaseUrl when in release mode', () async {
      BackendConstants.isDebugMode = false;

      final actualAuthorizationUrl = BackendConstants().backendBaseUrl();
      final expectedAuthorizationUrl = dotenv.env['API_URL']!;

      expect(actualAuthorizationUrl, expectedAuthorizationUrl);

      BackendConstants.isDebugMode = false;
    });
  });
}
