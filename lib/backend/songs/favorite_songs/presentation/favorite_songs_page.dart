// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// Project imports:
import 'package:joyful_noise/auth/shared/providers.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/backend/songs/core/presentation/song_drawer.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.dart';
import 'package:joyful_noise/search/presentation/search_bar.dart' as pub_search_bar;

@RoutePage()
class FavoriteSongsPage extends ConsumerStatefulWidget {
  const FavoriteSongsPage({super.key});

  @override
  FavoriteSongsPageState createState() => FavoriteSongsPageState();
}

class FavoriteSongsPageState extends ConsumerState<FavoriteSongsPage> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(favoriteSongsNotifierProvider.notifier).getNextFavoriteSongsPage();
      ref.read(userNotifierProvider.notifier).getUserPage();
    });

    super.initState();
  }

  static const signOutButtonKey = ValueKey('signOutButtonKey');

  @visibleForTesting
  static final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userNotifierProvider);
    Sentry.captureMessage('User Logged in: ${userState.user.email}');
    return Scaffold(
      key: scaffoldKey,
      drawer: const SongDrawer(),
      body: pub_search_bar.SearchBar(
        title: 'Favorite Songs',
        hint: 'Search all songs...',
        // coverage:ignore-start
        onShouldNavigateToResultPage: (searchTerm) {
          AutoRouter.of(context).push(SearchedSongsRoute(searchTerm: searchTerm));
        },
        // coverage:ignore-end
        onSignOutButtonPressed: () {
          ref.read(authNotifierProvider.notifier).signOut();
        },
        body: RefreshIndicator(
          // coverage:ignore-start

          /// Ignoring as the provider notifier refresh throws an error during
          /// tests due to the fact that the provider is disposed
          onRefresh: () {
            return Future.microtask(() {
              ref.refresh(favoriteSongsNotifierProvider.notifier).getFirstFavoriteSongsPage();
            });
            // coverage:ignore-end
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: PaginatedSongsListView(
              paginatedSongsNotifierProvider: favoriteSongsNotifierProvider,
              // coverage:ignore-start
              getNextPage: (ref, context) {
                // unable to mock this so this line isn't tested.
                ref.read(favoriteSongsNotifierProvider.notifier).getNextFavoriteSongsPage();
              },
              // coverage:ignore-end
              noResultsMessage: "That's everything we could find in your favorite songs right now.",
            ),
          ),
        ),
      ),
    );
  }
}
