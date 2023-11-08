// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Project imports:
import 'package:joyful_noise/auth/notifiers/auth_notifier.dart';
import 'package:joyful_noise/auth/shared/providers.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.dart';
import 'package:joyful_noise/core/presentation/styles/dark_style.dart';
import 'package:joyful_noise/core/presentation/styles/light_style.dart';
import 'package:joyful_noise/core/shared/providers.dart';

final initializationProvider = FutureProvider<Unit>(
  (ref) async {
    await ref.read(sembastProvider).init();
    ref.read(dioProvider)
      ..options = BaseOptions(
        // headers: <String, String>{'Accept': 'application/vnd.github.v3.html+json'},
        validateStatus: (status) => status != null && status >= 200 && status < 400,
      )
      ..interceptors.add(
        ref.read(oAuth2InterceptorProvider),
      );

    final authNotifier = ref.read(authNotifierProvider.notifier);
    await authNotifier.checkAndUpdateAuthStatus();
    return unit;
  },
);

class AppWidget extends ConsumerWidget {
  AppWidget({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(initializationProvider, (previous, next) {})
      ..listen<AuthState>(authNotifierProvider, (previous, next) {
        next.maybeMap(
          orElse: () {},
          authenticated: (_) {
            _appRouter.pushAndPopUntil(
              const FavoriteSongsRoute(),
              predicate: (route) => false,
            );
          },
          unauthenticated: (_) {
            _appRouter.pushAndPopUntil(
              const SignInRoute(),
              predicate: (route) => false,
            );
          },
        );
      });
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        defaultScale: true,
        minWidth: 480,
        defaultName: MOBILE,
        breakpoints: const [
          ResponsiveBreakpoint.resize(350, name: MOBILE),
          ResponsiveBreakpoint.autoScale(600, name: TABLET),
          ResponsiveBreakpoint.resize(800, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
        ],
      ),
      theme: lightTheme,
      darkTheme: darkTheme,
      title: 'Joyful Noise',
      routerDelegate: AutoRouterDelegate(
        _appRouter,
        navigatorObservers: () => [SentryNavigatorObserver()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
