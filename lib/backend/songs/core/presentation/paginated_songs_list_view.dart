// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:joyful_noise/backend/core/presentation/no_results_display.dart';
import 'package:joyful_noise/backend/songs/core/notifiers/paginated_songs_notifier.dart';
import 'package:joyful_noise/backend/songs/core/presentation/failure_song_tile.dart';
import 'package:joyful_noise/backend/songs/core/presentation/loading_song_tile.dart';
import 'package:joyful_noise/backend/songs/core/presentation/song_tile.dart';
import 'package:joyful_noise/core/presentation/toasts.dart';
import 'package:joyful_noise/core/shared/providers.dart';

class PaginatedSongsListView extends ConsumerStatefulWidget {
  final AutoDisposeStateNotifierProvider<PaginatedSongsNotifier, PaginatedSongsState> paginatedSongsNotifierProvider;
  final void Function(WidgetRef ref, BuildContext context) getNextPage;
  final String noResultsMessage;

  const PaginatedSongsListView({
    Key? key,
    required this.paginatedSongsNotifierProvider,
    required this.getNextPage,
    required this.noResultsMessage,
  }) : super(key: key);

  @override
  PaginatedSongsListViewState createState() => PaginatedSongsListViewState();
}

class PaginatedSongsListViewState extends ConsumerState<PaginatedSongsListView> {
  bool canLoadNextPage = false;
  bool hasAlreadyShownNoConnectionToast = false;

  @override
  Widget build(BuildContext context) {
    ref.listen<PaginatedSongsState>(
      widget.paginatedSongsNotifierProvider,
      (_, state) {
        state.map(
          initial: (_) => canLoadNextPage = true,
          loadInProgress: (_) => canLoadNextPage = false,
          loadSuccess: (_) {
            if (!_.songs.isFresh && !hasAlreadyShownNoConnectionToast) {
              hasAlreadyShownNoConnectionToast = true;
              showNoConnectionToast(
                "You're not online. Some information may be outdated.",
                context,
              );
            }
            canLoadNextPage = _.isNextPageAvailable;
          },
          loadFailure: (_) => canLoadNextPage = false,
        );
      },
    );
    final state = ref.watch(favoriteSongsNotifierProvider);
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        final limit = metrics.maxScrollExtent - metrics.viewportDimension / 3;

        if (canLoadNextPage && metrics.pixels >= limit) {
          canLoadNextPage = false;
          widget.getNextPage(ref, context);
        }
        return false;
      },
      child: state.maybeWhen(
        loadSuccess: (songs, _) => songs.entity.isEmpty,
        orElse: () => false,
      )
          ? const NoResultsDisplay(message: 'There was nothing to be found :(')
          : _PaginatedListView(state: state),
    );
  }
}

class _PaginatedListView extends StatelessWidget {
  const _PaginatedListView({
    Key? key,
    required this.state,
  }) : super(key: key);

  final PaginatedSongsState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.map(
        initial: (_) => 0,
        loadInProgress: (_) => _.songs.entity.length + _.itemsPerPage,
        loadSuccess: (_) => _.songs.entity.length,
        // +1 error message
        loadFailure: (_) => _.songs.entity.length + 1,
      ),
      itemBuilder: (context, index) {
        return state.map(
          initial: (_) => SongTile(
            song: _.songs.entity[index],
          ),
          loadInProgress: (_) {
            if (index < _.songs.entity.length) {
              return SongTile(
                song: _.songs.entity[index],
              );
            } else {
              return const LoadingSongTile();
            }
          },
          loadSuccess: (_) => SongTile(
            song: _.songs.entity[index],
          ),
          loadFailure: (_) => FailureSongTile(
            githubFailure: _.failure,
          ),
        );
      },
    );
  }
}
