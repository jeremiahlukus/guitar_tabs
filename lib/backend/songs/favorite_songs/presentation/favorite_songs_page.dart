// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:websafe_svg/websafe_svg.dart';

// Project imports:
import 'package:joyful_noise/auth/shared/providers.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';
import 'package:joyful_noise/search/presentation/search_bar.dart';

class FavoriteSongsPage extends ConsumerStatefulWidget {
  const FavoriteSongsPage({Key? key}) : super(key: key);

  @override
  FavoriteSongsPageState createState() => FavoriteSongsPageState();
}

class FavoriteSongsPageState extends ConsumerState<FavoriteSongsPage> {
  @override
  void initState() {
    ref.read(favoriteSongsNotifierProvider.notifier).getNextFavoriteSongsPage();
    super.initState();
  }

  static const signOutButtonKey = ValueKey('signOutButtonKey');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: WebsafeSvg.asset('assets/logo.svg'),
            ),
            ListTile(
              title: const Text('Athens Song Book'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('English Hymnal'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Blue Songbook'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Himnos'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Liederbuch'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Cantiques'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: SearchBar(
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
          onRefresh: () {
            setState(() {});
            return ref.read(favoriteSongsNotifierProvider.notifier).getFirstFavoriteSongsPage();
          },
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
    );
  }
}
