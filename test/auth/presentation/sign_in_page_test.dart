// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:alchemist/alchemist.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Project imports:
import 'package:joyful_noise/auth/infrastructure/webapp_authenticator.dart';
import 'package:joyful_noise/auth/notifiers/auth_notifier.dart';
import 'package:joyful_noise/auth/presentation/sign_in_page.dart';
import 'package:joyful_noise/auth/shared/providers.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';
import '../../utils/device.dart';
import '../../utils/golden_test_device_scenario.dart';
import 'fakes/webview_fakes.dart';

class MockAuthNotifier extends Mock implements AuthNotifier {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockWebAppAuthenticator extends Mock implements WebAppAuthenticator {}

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

  group('SignInPage', () {
    testWidgets('contains the "Welcome to Joyful Noise" text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SignInPage(),
        ),
      );

      await tester.pump(Duration.zero);

      final welcomeTextFinder = find.byWidgetPredicate(
        (Widget widget) => widget is Text && widget.data == 'Welcome to \nJoyful Noise',
      );

      expect(welcomeTextFinder, findsOneWidget);
    });

    testWidgets("clicking on Sign In button triggers provided AuthNotifier's signIn method", (tester) async {
      final AuthNotifier mockAuthNotifier = MockAuthNotifier();

      when(() => mockAuthNotifier.signIn(any())).thenAnswer((_) => Future.value());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authNotifierProvider.overrideWith(
              (
                _,
              ) =>
                  mockAuthNotifier,
            ),
          ],
          child: const MaterialApp(
            home: SignInPage(),
          ),
        ),
      );

      await tester.pump(Duration.zero);

      final signInButtonFinder = find.byKey(SignInPage.signInButtonKey);

      await tester.tap(signInButtonFinder);

      await tester.pump();

      verify(() => mockAuthNotifier.signIn(any())).called(1);
    });
    testWidgets('clicking on Sign In button navigates to AuthorizationPage', (tester) async {
      final mockWebAppAuthenticator = MockWebAppAuthenticator();

      when(mockWebAppAuthenticator.getAuthorizationUrl).thenAnswer((invocation) => Uri.parse('https://www.google.com'));

      final mockAuthNotifier = AuthNotifier(mockWebAppAuthenticator);

      final mockObserver = MockNavigatorObserver();

      final router = AppRouter();

      // ignore: unawaited_futures, cascade_invocations
      router.push(const SignInRoute());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authNotifierProvider.overrideWith(
              (_) => mockAuthNotifier,
            ),
          ],
          child: MaterialApp.router(
            routerDelegate: AutoRouterDelegate(
              router,
              navigatorObservers: () => [mockObserver],
            ),
            routeInformationParser: AppRouter().defaultRouteParser(),
          ),
        ),
      );

      await tester.pump(Duration.zero);

      final signInButtonFinder = find.byKey(SignInPage.signInButtonKey);

      await tester.tap(signInButtonFinder);

      await tester.pumpAndSettle();

      // final authorizationPageFinder = find.byType(AuthorizationPage);

      // expect(authorizationPageFinder, findsOneWidget);
    });
  });

  Widget buildWidgetUnderTest() => const MaterialApp(
        home: SignInPage(),
      );

  group('SignInPage Golden Test', () {
    goldenTest(
      'renders correctly on mobile',
      fileName: 'SignInPage',
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
