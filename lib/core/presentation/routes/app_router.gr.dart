// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../../auth/presentation/authorization_page.dart' as _i3;
import '../../../auth/presentation/sign_in_page.dart' as _i2;
import '../../../backend/core/domain/song.dart' as _i10;
import '../../../backend/songs/favorite_songs/presentation/favorite_songs_page.dart'
    as _i4;
import '../../../backend/songs/playlist_songs/presentation/playlist_songs_page.dart'
    as _i5;
import '../../../backend/songs/searched_songs/presentation/searched_songs_page.dart'
    as _i6;
import '../../../backend/songs/song_detail/presentation/song_detail_page.dart'
    as _i7;
import '../../../splash/presentation/splash_page.dart' as _i1;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SignInPage(),
      );
    },
    AuthorizationRoute.name: (routeData) {
      final args = routeData.argsAs<AuthorizationRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.AuthorizationPage(
          authorizationUrl: args.authorizationUrl,
          onAuthorizationCodeRedirectAttempt:
              args.onAuthorizationCodeRedirectAttempt,
          key: args.key,
        ),
      );
    },
    FavoriteSongsRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.FavoriteSongsPage(),
      );
    },
    PlaylistSongsRoute.name: (routeData) {
      final args = routeData.argsAs<PlaylistSongsRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.PlaylistSongsPage(
          playlistName: args.playlistName,
          key: args.key,
        ),
      );
    },
    SearchedSongsRoute.name: (routeData) {
      final args = routeData.argsAs<SearchedSongsRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.SearchedSongsPage(
          searchTerm: args.searchTerm,
          key: args.key,
        ),
      );
    },
    SongDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SongDetailRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.SongDetailPage(
          song: args.song,
          key: args.key,
        ),
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i8.RouteConfig(
          SignInRoute.name,
          path: '/sign_in',
        ),
        _i8.RouteConfig(
          AuthorizationRoute.name,
          path: '/auth',
        ),
        _i8.RouteConfig(
          FavoriteSongsRoute.name,
          path: '/favorite_songs',
        ),
        _i8.RouteConfig(
          PlaylistSongsRoute.name,
          path: '/playlist_songs',
        ),
        _i8.RouteConfig(
          SearchedSongsRoute.name,
          path: '/searched_songs',
        ),
        _i8.RouteConfig(
          SongDetailRoute.name,
          path: '/song_detail',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.SignInPage]
class SignInRoute extends _i8.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: '/sign_in',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.AuthorizationPage]
class AuthorizationRoute extends _i8.PageRouteInfo<AuthorizationRouteArgs> {
  AuthorizationRoute({
    required Uri authorizationUrl,
    required void Function(Uri) onAuthorizationCodeRedirectAttempt,
    _i9.Key? key,
  }) : super(
          AuthorizationRoute.name,
          path: '/auth',
          args: AuthorizationRouteArgs(
            authorizationUrl: authorizationUrl,
            onAuthorizationCodeRedirectAttempt:
                onAuthorizationCodeRedirectAttempt,
            key: key,
          ),
        );

  static const String name = 'AuthorizationRoute';
}

class AuthorizationRouteArgs {
  const AuthorizationRouteArgs({
    required this.authorizationUrl,
    required this.onAuthorizationCodeRedirectAttempt,
    this.key,
  });

  final Uri authorizationUrl;

  final void Function(Uri) onAuthorizationCodeRedirectAttempt;

  final _i9.Key? key;

  @override
  String toString() {
    return 'AuthorizationRouteArgs{authorizationUrl: $authorizationUrl, onAuthorizationCodeRedirectAttempt: $onAuthorizationCodeRedirectAttempt, key: $key}';
  }
}

/// generated route for
/// [_i4.FavoriteSongsPage]
class FavoriteSongsRoute extends _i8.PageRouteInfo<void> {
  const FavoriteSongsRoute()
      : super(
          FavoriteSongsRoute.name,
          path: '/favorite_songs',
        );

  static const String name = 'FavoriteSongsRoute';
}

/// generated route for
/// [_i5.PlaylistSongsPage]
class PlaylistSongsRoute extends _i8.PageRouteInfo<PlaylistSongsRouteArgs> {
  PlaylistSongsRoute({
    required String playlistName,
    _i9.Key? key,
  }) : super(
          PlaylistSongsRoute.name,
          path: '/playlist_songs',
          args: PlaylistSongsRouteArgs(
            playlistName: playlistName,
            key: key,
          ),
        );

  static const String name = 'PlaylistSongsRoute';
}

class PlaylistSongsRouteArgs {
  const PlaylistSongsRouteArgs({
    required this.playlistName,
    this.key,
  });

  final String playlistName;

  final _i9.Key? key;

  @override
  String toString() {
    return 'PlaylistSongsRouteArgs{playlistName: $playlistName, key: $key}';
  }
}

/// generated route for
/// [_i6.SearchedSongsPage]
class SearchedSongsRoute extends _i8.PageRouteInfo<SearchedSongsRouteArgs> {
  SearchedSongsRoute({
    required String searchTerm,
    _i9.Key? key,
  }) : super(
          SearchedSongsRoute.name,
          path: '/searched_songs',
          args: SearchedSongsRouteArgs(
            searchTerm: searchTerm,
            key: key,
          ),
        );

  static const String name = 'SearchedSongsRoute';
}

class SearchedSongsRouteArgs {
  const SearchedSongsRouteArgs({
    required this.searchTerm,
    this.key,
  });

  final String searchTerm;

  final _i9.Key? key;

  @override
  String toString() {
    return 'SearchedSongsRouteArgs{searchTerm: $searchTerm, key: $key}';
  }
}

/// generated route for
/// [_i7.SongDetailPage]
class SongDetailRoute extends _i8.PageRouteInfo<SongDetailRouteArgs> {
  SongDetailRoute({
    required _i10.Song song,
    _i9.Key? key,
  }) : super(
          SongDetailRoute.name,
          path: '/song_detail',
          args: SongDetailRouteArgs(
            song: song,
            key: key,
          ),
        );

  static const String name = 'SongDetailRoute';
}

class SongDetailRouteArgs {
  const SongDetailRouteArgs({
    required this.song,
    this.key,
  });

  final _i10.Song song;

  final _i9.Key? key;

  @override
  String toString() {
    return 'SongDetailRouteArgs{song: $song, key: $key}';
  }
}
