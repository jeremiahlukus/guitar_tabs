// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../../../auth/presentation/authorization_page.dart' as _i3;
import '../../../auth/presentation/sign_in_page.dart' as _i2;
import '../../../backend/dashboard/presentation/dashboard_page.dart' as _i4;
import '../../../backend/songs/favorite_songs/presentation/favorite_songs_page.dart'
    as _i5;
import '../../../backend/songs/searched_songs/presentation/searched_songs_page.dart'
    as _i6;
import '../../../splash/presentation/splash_page.dart' as _i1;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashPage());
    },
    SignInRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SignInPage());
    },
    AuthorizationRoute.name: (routeData) {
      final args = routeData.argsAs<AuthorizationRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.AuthorizationPage(
              key: args.key,
              authorizationUrl: args.authorizationUrl,
              onAuthorizationCodeRedirectAttempt:
                  args.onAuthorizationCodeRedirectAttempt));
    },
    DashboardRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.DashboardPage());
    },
    FavoriteSongsRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.FavoriteSongsPage());
    },
    SearchedSongsRoute.name: (routeData) {
      final args = routeData.argsAs<SearchedSongsRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.SearchedSongsPage(
              key: args.key, searchTerm: args.searchTerm));
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(SplashRoute.name, path: '/'),
        _i7.RouteConfig(SignInRoute.name, path: '/sign-in'),
        _i7.RouteConfig(AuthorizationRoute.name, path: '/auth'),
        _i7.RouteConfig(DashboardRoute.name, path: '/dashboard'),
        _i7.RouteConfig(FavoriteSongsRoute.name, path: '/favorite_songs'),
        _i7.RouteConfig(SearchedSongsRoute.name, path: '/searched_songs')
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.SignInPage]
class SignInRoute extends _i7.PageRouteInfo<void> {
  const SignInRoute() : super(SignInRoute.name, path: '/sign-in');

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.AuthorizationPage]
class AuthorizationRoute extends _i7.PageRouteInfo<AuthorizationRouteArgs> {
  AuthorizationRoute(
      {_i8.Key? key,
      required Uri authorizationUrl,
      required void Function(Uri) onAuthorizationCodeRedirectAttempt})
      : super(AuthorizationRoute.name,
            path: '/auth',
            args: AuthorizationRouteArgs(
                key: key,
                authorizationUrl: authorizationUrl,
                onAuthorizationCodeRedirectAttempt:
                    onAuthorizationCodeRedirectAttempt));

  static const String name = 'AuthorizationRoute';
}

class AuthorizationRouteArgs {
  const AuthorizationRouteArgs(
      {this.key,
      required this.authorizationUrl,
      required this.onAuthorizationCodeRedirectAttempt});

  final _i8.Key? key;

  final Uri authorizationUrl;

  final void Function(Uri) onAuthorizationCodeRedirectAttempt;

  @override
  String toString() {
    return 'AuthorizationRouteArgs{key: $key, authorizationUrl: $authorizationUrl, onAuthorizationCodeRedirectAttempt: $onAuthorizationCodeRedirectAttempt}';
  }
}

/// generated route for
/// [_i4.DashboardPage]
class DashboardRoute extends _i7.PageRouteInfo<void> {
  const DashboardRoute() : super(DashboardRoute.name, path: '/dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i5.FavoriteSongsPage]
class FavoriteSongsRoute extends _i7.PageRouteInfo<void> {
  const FavoriteSongsRoute()
      : super(FavoriteSongsRoute.name, path: '/favorite_songs');

  static const String name = 'FavoriteSongsRoute';
}

/// generated route for
/// [_i6.SearchedSongsPage]
class SearchedSongsRoute extends _i7.PageRouteInfo<SearchedSongsRouteArgs> {
  SearchedSongsRoute({_i8.Key? key, required String searchTerm})
      : super(SearchedSongsRoute.name,
            path: '/searched_songs',
            args: SearchedSongsRouteArgs(key: key, searchTerm: searchTerm));

  static const String name = 'SearchedSongsRoute';
}

class SearchedSongsRouteArgs {
  const SearchedSongsRouteArgs({this.key, required this.searchTerm});

  final _i8.Key? key;

  final String searchTerm;

  @override
  String toString() {
    return 'SearchedSongsRouteArgs{key: $key, searchTerm: $searchTerm}';
  }
}
