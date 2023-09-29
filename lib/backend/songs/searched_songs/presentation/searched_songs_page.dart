// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:joyful_noise/auth/shared/providers.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';
import 'package:joyful_noise/search/presentation/search_bar.dart' as PubSearchBar;

class SearchedSongsPage extends ConsumerStatefulWidget {
  final String searchTerm;
  const SearchedSongsPage({
    required this.searchTerm,
    super.key,
  });

  @override
  SearchedSongsPageState createState() => SearchedSongsPageState();
}

class SearchedSongsPageState extends ConsumerState<SearchedSongsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(searchedSongsNotifierProvider.notifier).getFirstSearchedSongsPage(widget.searchTerm);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PubSearchBar.SearchBar(
        title: widget.searchTerm,
        hint: 'Search all songs...',
        // coverage:ignore-start
        onShouldNavigateToResultPage: (searchTerm) {
          AutoRouter.of(context).pushAndPopUntil(
            SearchedSongsRoute(searchTerm: searchTerm),
            predicate: (route) => route.settings.name == SearchedSongsRoute.name,
          );
        },
        // coverage:ignore-end
        onSignOutButtonPressed: () {
          ref.read(authNotifierProvider.notifier).signOut();
        },
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: PaginatedSongsListView(
            paginatedSongsNotifierProvider: searchedSongsNotifierProvider,
            // coverage:ignore-start
            getNextPage: (ref, context) {
              // unable to mock this so this line isn't tested.
              ref.read(searchedSongsNotifierProvider.notifier).getNextSearchedSongsPage(widget.searchTerm);
            },
            // coverage:ignore-end
            noResultsMessage: 'This is all we could find for your search term.',
          ),
        ),
      ),
    );
  }
}
