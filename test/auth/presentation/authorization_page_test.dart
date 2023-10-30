// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Project imports:
import 'package:joyful_noise/auth/infrastructure/webapp_authenticator.dart';
import 'package:joyful_noise/auth/presentation/authorization_page.dart';
import 'fakes/webview_fakes.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockNavigationRequest extends Mock implements NavigationRequest {}

class MockOnAuthorizationCodeRedirectAttemptCallback extends Mock
    implements OnAuthorizationCodeRedirectAttemptCallback {}

// ignore: one_member_abstracts
abstract class OnAuthorizationCodeRedirectAttemptCallback {
  void Function(Uri) call();
}

void main() {
  final controller = FakeWebViewController(const PlatformWebViewControllerCreationParams());
  final cookieManager = FakeCookieManager(const PlatformWebViewCookieManagerCreationParams());

  WebViewPlatform.instance = FakeWebViewPlatform(controller: controller, cookieManager: cookieManager);

  setUpAll(() {
    registerFallbackValue(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return Container();
        },
      ),
    );
  });
  group('AuthorizationPage', () {
    testWidgets('shows a WebView', (tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: AuthorizationPage(
            authorizationUrl: Uri.parse('https://www.google.com'),
            onAuthorizationCodeRedirectAttempt: (Uri _) => <String, String>{},
          ),
          navigatorObservers: [mockObserver],
        ),
      );

      await tester.pump(Duration.zero);

      final webViewWidgetFinder = find.byType(WebViewWidget);

      expect(webViewWidgetFinder, findsOneWidget);
    });

    testWidgets('WebViewController clears cached when the page is created', (tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: AuthorizationPage(
            authorizationUrl: Uri.parse('https://www.google.com'),
            onAuthorizationCodeRedirectAttempt: (Uri _) => <String, String>{},
          ),
          navigatorObservers: [mockObserver],
        ),
      );

      await tester.pump(Duration.zero);

      expect(cookieManager.clearCookiesCalled, true);
    });

    testWidgets(
        "the onAuthorizationCodeRedirectAttempt callback is called when the WebView's navigationDelegate method is called",
        (tester) async {
      final mockObserver = MockNavigatorObserver();

      final OnAuthorizationCodeRedirectAttemptCallback mockOnAuthorizationCodeRedirectAttemptCallback =
          MockOnAuthorizationCodeRedirectAttemptCallback();

      when(mockOnAuthorizationCodeRedirectAttemptCallback.call).thenReturn((_) {});

      await tester.pumpWidget(
        MaterialApp(
          home: AuthorizationPage(
            authorizationUrl: Uri.parse('https://www.google.com'),
            onAuthorizationCodeRedirectAttempt: mockOnAuthorizationCodeRedirectAttemptCallback(),
          ),
          navigatorObservers: [mockObserver],
        ),
      );

      await tester.pump(Duration.zero);

      final NavigationRequest mockNavigationRequest = MockNavigationRequest();

      when(() => mockNavigationRequest.url).thenReturn('${WebAppAuthenticator.redirectUrl()}');

      // ignore: unnecessary_lambdas
      verify(() => mockOnAuthorizationCodeRedirectAttemptCallback()).called(1);
    });
  });
}
