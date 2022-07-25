// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:joyful_noise/auth/shared/providers.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/core/shared/providers.dart';

class SearchedSongsPage extends ConsumerStatefulWidget {
  final String searchTerm;
  const SearchedSongsPage({Key? key, required this.searchTerm}) : super(key: key);

  @override
  SearchedSongsPageState createState() => SearchedSongsPageState();
}

class SearchedSongsPageState extends ConsumerState<SearchedSongsPage> {
  @override
  void initState() {
    ref.read(searchedSongsNotifierProvider.notifier).getFirstSearchedSongsPage(widget.searchTerm);
    super.initState();
  }

  static const signOutButtonKey = ValueKey('signOutButtonKey');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchTerm),
        actions: [
          IconButton(
            key: signOutButtonKey,
            onPressed: () {
              ref.read(authNotifierProvider.notifier).signOut();
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
            ),
          )
        ],
      ),
      body: PaginatedSongsListView(
        paginatedSongsNotifierProvider: searchedSongsNotifierProvider,
        // coverage:ignore-start
        getNextPage: (ref, context) {
          // unable to mock this so this line isn't tested.
          ref.read(searchedSongsNotifierProvider.notifier).getNextSearchedSongsPage(widget.searchTerm);
        },
        // coverage:ignore-end
        noResultsMessage: 'This is all we could find for your search term.',
      ),
    );
  }
}
