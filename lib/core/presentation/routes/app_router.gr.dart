// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthorizationRoute.name: (routeData) {
      final args = routeData.argsAs<AuthorizationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AuthorizationPage(
          authorizationUrl: args.authorizationUrl,
          onAuthorizationCodeRedirectAttempt: args.onAuthorizationCodeRedirectAttempt,
          key: args.key,
        ),
      );
    },
    FavoriteSongsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoriteSongsPage(),
      );
    },
    PlaylistSongsRoute.name: (routeData) {
      final args = routeData.argsAs<PlaylistSongsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PlaylistSongsPage(
          playlistName: args.playlistName,
          key: args.key,
        ),
      );
    },
    SearchedSongsRoute.name: (routeData) {
      final args = routeData.argsAs<SearchedSongsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SearchedSongsPage(
          searchTerm: args.searchTerm,
          playlistName: args.playlistName,
          key: args.key,
        ),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInPage(),
      );
    },
    SongDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SongDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SongDetailPage(
          song: args.song,
          key: args.key,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    TunerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TunerPage(),
      );
    },
  };
}

/// generated route for
/// [AuthorizationPage]
class AuthorizationRoute extends PageRouteInfo<AuthorizationRouteArgs> {
  AuthorizationRoute({
    required Uri authorizationUrl,
    required void Function(Uri) onAuthorizationCodeRedirectAttempt,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AuthorizationRoute.name,
          args: AuthorizationRouteArgs(
            authorizationUrl: authorizationUrl,
            onAuthorizationCodeRedirectAttempt: onAuthorizationCodeRedirectAttempt,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AuthorizationRoute';

  static const PageInfo<AuthorizationRouteArgs> page = PageInfo<AuthorizationRouteArgs>(name);
}

class AuthorizationRouteArgs {
  const AuthorizationRouteArgs({
    required this.authorizationUrl,
    required this.onAuthorizationCodeRedirectAttempt,
    this.key,
  });

  final Uri authorizationUrl;

  final void Function(Uri) onAuthorizationCodeRedirectAttempt;

  final Key? key;

  @override
  String toString() {
    return 'AuthorizationRouteArgs{authorizationUrl: $authorizationUrl, onAuthorizationCodeRedirectAttempt: $onAuthorizationCodeRedirectAttempt, key: $key}';
  }
}

/// generated route for
/// [FavoriteSongsPage]
class FavoriteSongsRoute extends PageRouteInfo<void> {
  const FavoriteSongsRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteSongsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteSongsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PlaylistSongsPage]
class PlaylistSongsRoute extends PageRouteInfo<PlaylistSongsRouteArgs> {
  PlaylistSongsRoute({
    required String playlistName,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          PlaylistSongsRoute.name,
          args: PlaylistSongsRouteArgs(
            playlistName: playlistName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PlaylistSongsRoute';

  static const PageInfo<PlaylistSongsRouteArgs> page = PageInfo<PlaylistSongsRouteArgs>(name);
}

class PlaylistSongsRouteArgs {
  const PlaylistSongsRouteArgs({
    required this.playlistName,
    this.key,
  });

  final String playlistName;

  final Key? key;

  @override
  String toString() {
    return 'PlaylistSongsRouteArgs{playlistName: $playlistName, key: $key}';
  }
}

/// generated route for
/// [SearchedSongsPage]
class SearchedSongsRoute extends PageRouteInfo<SearchedSongsRouteArgs> {
  SearchedSongsRoute({
    required String searchTerm,
    String playlistName = '',
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SearchedSongsRoute.name,
          args: SearchedSongsRouteArgs(
            searchTerm: searchTerm,
            playlistName: playlistName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SearchedSongsRoute';

  static const PageInfo<SearchedSongsRouteArgs> page = PageInfo<SearchedSongsRouteArgs>(name);
}

class SearchedSongsRouteArgs {
  const SearchedSongsRouteArgs({
    required this.searchTerm,
    this.playlistName = '',
    this.key,
  });

  final String searchTerm;

  final String playlistName;

  final Key? key;

  @override
  String toString() {
    return 'SearchedSongsRouteArgs{searchTerm: $searchTerm, playlistName: $playlistName, key: $key}';
  }
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SongDetailPage]
class SongDetailRoute extends PageRouteInfo<SongDetailRouteArgs> {
  SongDetailRoute({
    required Song song,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SongDetailRoute.name,
          args: SongDetailRouteArgs(
            song: song,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SongDetailRoute';

  static const PageInfo<SongDetailRouteArgs> page = PageInfo<SongDetailRouteArgs>(name);
}

class SongDetailRouteArgs {
  const SongDetailRouteArgs({
    required this.song,
    this.key,
  });

  final Song song;

  final Key? key;

  @override
  String toString() {
    return 'SongDetailRouteArgs{song: $song, key: $key}';
  }
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TunerPage]
class TunerRoute extends PageRouteInfo<void> {
  const TunerRoute({List<PageRouteInfo>? children})
      : super(
          TunerRoute.name,
          initialChildren: children,
        );

  static const String name = 'TunerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
