import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

Future<void> pumpRouterApp(
  WidgetTester tester,
  List<Override> providers,
  RootStackRouter router, {
  String? initialLink,
}) {
  final mockObserver = MockNavigatorObserver();
  return tester
      .pumpWidget(
        ProviderScope(
          overrides: providers,
          child: MaterialApp.router(
            routerDelegate: AutoRouterDelegate(
              router,
              navigatorObservers: () => [mockObserver],
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
