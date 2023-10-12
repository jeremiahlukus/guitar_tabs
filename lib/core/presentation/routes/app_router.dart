// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';

// Project imports:
import 'package:joyful_noise/auth/presentation/authorization_page.dart';
import 'package:joyful_noise/auth/presentation/sign_in_page.dart';
import 'package:joyful_noise/backend/songs/favorite_songs/presentation/favorite_songs_page.dart';
import 'package:joyful_noise/backend/songs/playlist_songs/presentation/playlist_songs_page.dart';
import 'package:joyful_noise/backend/songs/searched_songs/presentation/searched_songs_page.dart';
import 'package:joyful_noise/backend/songs/song_detail/presentation/song_detail_page.dart';
import 'package:joyful_noise/splash/presentation/splash_page.dart';
import '../../../backend/core/domain/song.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: SignInRoute.page, path: '/sign_in'),
        AutoRoute(page: AuthorizationRoute.page, path: '/auth'),
        AutoRoute(page: FavoriteSongsRoute.page, path: '/favorite_songs'),
        AutoRoute(page: PlaylistSongsRoute.page, path: '/playlist_songs'),
        AutoRoute(page: SearchedSongsRoute.page, path: '/searched_songs'),
        AutoRoute(page: SongDetailRoute.page, path: '/song_detail'),
      ];
}

// @MaterialAutoRouter(
//   replaceInRouteName: 'Page,Route',
//   routes: <AutoRoute>[
//     AutoRoute<dynamic>(page: SplashPage, initial: true),
//     AutoRoute<dynamic>(page: SignInPage, path: '/sign_in'),
//     AutoRoute<dynamic>(page: AuthorizationPage, path: '/auth'),
//     AutoRoute<dynamic>(page: FavoriteSongsPage, path: '/favorite_songs'),
//     AutoRoute<dynamic>(page: PlaylistSongsPage, path: '/playlist_songs'),
//     AutoRoute<dynamic>(page: SearchedSongsPage, path: '/searched_songs'),
//     AutoRoute<dynamic>(page: SongDetailPage, path: '/song_detail'),
//   ],
// )
// class $AppRouter {}
