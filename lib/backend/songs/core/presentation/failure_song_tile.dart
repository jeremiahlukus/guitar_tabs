// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';

class FailureSongTile extends ConsumerWidget {
  final BackendFailure backendFailure;
  const FailureSongTile({
    required this.backendFailure,
    Key? key,
  }) : super(key: key);

  static const getNextFavoriteSongsButtonKey = ValueKey('getNextFavoriteSongsButtonKey');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTileTheme(
      textColor: Theme.of(context).colorScheme.onError,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Theme.of(context).colorScheme.error,
        child: ListTile(
          title: const Text('An error occurred please retry'),
          subtitle: Text(
            backendFailure.map(api: (api) => 'API returned: ${api.errorCode}'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: const SizedBox(
            height: double.infinity,
            child: Icon(
              Icons.warning,
              color: Colors.white,
            ),
          ),
          trailing: IconButton(
            key: getNextFavoriteSongsButtonKey,
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(favoriteSongsNotifierProvider.notifier).getNextFavoriteSongsPage();
            },
          ),
        ),
      ),
    );
  }
}
