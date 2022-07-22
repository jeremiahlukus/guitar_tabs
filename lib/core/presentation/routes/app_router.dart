// Package imports:
import 'package:auto_route/auto_route.dart';

// Project imports:
import 'package:joyful_noise/auth/presentation/authorization_page.dart';
import 'package:joyful_noise/auth/presentation/sign_in_page.dart';
import 'package:joyful_noise/backend/dashboard/presentation/dashboard_page.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/presentation/favorite_songs_page.dart';
import 'package:joyful_noise/splash/presentation/splash_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<dynamic>(page: SplashPage, initial: true),
    AutoRoute<dynamic>(page: SignInPage, path: '/sign-in'),
    AutoRoute<dynamic>(page: AuthorizationPage, path: '/auth'),
    AutoRoute<dynamic>(page: DashboardPage, path: '/dashboard'),
    AutoRoute<dynamic>(page: FavoriteSongsPage, path: '/favorite_songs'),
  ],
)
class $AppRouter {}
