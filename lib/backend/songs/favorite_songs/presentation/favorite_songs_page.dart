// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:joyful_noise/auth/shared/providers.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/core/shared/providers.dart';

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
      appBar: AppBar(
        title: const Text('Favorite Songs'),
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
        paginatedSongsNotifierProvider: favoriteSongsNotifierProvider,
        getNextPage: (ref, context) {
          ref.read(favoriteSongsNotifierProvider.notifier).getNextFavoriteSongsPage();
        },
        noResultsMessage: "That's everything we could find in your favorite songs right now.",
      ),
    );
  }
}
