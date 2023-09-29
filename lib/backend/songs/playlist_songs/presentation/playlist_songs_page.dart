// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

// Project imports:
import 'package:joyful_noise/auth/shared/providers.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';
import 'package:joyful_noise/search/presentation/search_bar.dart' as PubSearchBar;

class PlaylistSongsPage extends ConsumerStatefulWidget {
  final String playlistName;
  const PlaylistSongsPage({
    required this.playlistName,
    super.key,
  });

  @override
  PlaylistSongsPageState createState() => PlaylistSongsPageState();
}

class PlaylistSongsPageState extends ConsumerState<PlaylistSongsPage> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(playlistSongsNotifierProvider.notifier).getFirstPlaylistSongsPage(widget.playlistName);
    });

    super.initState();
  }

  static const signOutButtonKey = ValueKey('signOutButtonKey');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PubSearchBar.SearchBar(
        title: '${toBeginningOfSentenceCase(widget.playlistName)} Songs',
        hint: 'Search all songs...',
        // coverage:ignore-start
        onShouldNavigateToResultPage: (searchTerm) {
          AutoRouter.of(context).push(SearchedSongsRoute(searchTerm: searchTerm));
        },
        // coverage:ignore-end
        onSignOutButtonPressed: () {
          ref.read(authNotifierProvider.notifier).signOut();
        },
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: PaginatedSongsListView(
            paginatedSongsNotifierProvider: playlistSongsNotifierProvider,
            // coverage:ignore-start
            getNextPage: (ref, context) {
              // unable to mock this so this line isn't tested.
              ref.read(playlistSongsNotifierProvider.notifier).getNextPlaylistSongsPage(widget.playlistName);
            },
            // coverage:ignore-end
            noResultsMessage: "That's everything we could find right now.",
          ),
        ),
      ),
    );
  }
}
