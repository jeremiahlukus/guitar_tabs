import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:joyful_noise/backend/core/domain/backend_failure.dart';
import 'package:joyful_noise/core/shared/providers.dart';

class FailureSongTile extends ConsumerWidget {
  final BackendFailure githubFailure;
  const FailureSongTile({
    Key? key,
    required this.githubFailure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTileTheme(
      textColor: Theme.of(context).colorScheme.onError,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Theme.of(context).errorColor,
        child: ListTile(
          title: const Text('An error occurred please retry'),
          subtitle: Text(
            githubFailure.map(api: (api) => 'API returned: ${api.errorCode}'),
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
