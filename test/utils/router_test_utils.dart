// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

// Project imports:
import 'package:joyful_noise/core/presentation/routes/app_router.dart';

// Project imports:

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

Future<void> pumpRouterApp(
  WidgetTester tester,
  List<Override> providers,
  RootStackRouter router, {
  String? initialLink,
  NavigatorObserver? mockObserverOverride,
}) {
  final mockObserver = MockNavigatorObserver();
  return tester
      .pumpWidget(
        ProviderScope(
          overrides: providers,
          child: MaterialApp.router(
            routerDelegate: AutoRouterDelegate(
              router,
              navigatorObservers: () => [mockObserverOverride ?? mockObserver],
            ),
            routeInformationParser: AppRouter().defaultRouteParser(),
          ),
        ),
      )
      .then((_) => tester.pumpAndSettle());
}

void expectCurrentPage(StackRouter router, String name) {
  expect(router.current.name, name);
  expect(find.text(name), findsOneWidget);
}

void expectTopPage(StackRouter router, String name) {
  expect(router.topRoute.name, name);
  expect(find.text(name), findsOneWidget);
}
