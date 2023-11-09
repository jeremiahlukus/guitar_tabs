// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:joyful_noise/auth/shared/providers.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.dart';

class SongDrawer extends ConsumerWidget {
  const SongDrawer({super.key});
  static const drawerKey = ValueKey('drawerKey');
  static const tunerKey = ValueKey('tunerKey');
  static const favoriteKey = ValueKey('favoriteKey');
  static const athensSongBook = ValueKey('athensSongBook');
  static const hymnal = ValueKey('hymnal');
  static const blueSongbook = ValueKey('blueSongbook');
  static const himnos = ValueKey('himnos');
  static const liederbuch = ValueKey('liederbuch');
  static const cantiques = ValueKey('cantiques');
  static const signOut = ValueKey('signOut');
  static const deleteUser = ValueKey('deleteUser');
  static const noDeleteUser = ValueKey('noDeleteUser');
  static const yesDeleteUser = ValueKey('yesDeleteUser');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    timeDilation = 0.0001;
    return Drawer(
      key: drawerKey,
      child: ListView(
        // Important: Remove any padding from the ListView.
        // padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 25),
          ListTile(
            key: tunerKey,
            title: const Text('Guitar Tuner'),
            onTap: () {
              AutoRouter.of(context).push(const TunerRoute());
              Navigator.of(context).pop();
              timeDilation = 1;
            },
          ),
          ListTile(
            key: favoriteKey,
            title: const Text('Favorite Songs'),
            subtitle: const Text('(Search ALL songs)'),
            onTap: () async {
              Navigator.of(context).pop();
              if (AutoRouter.of(context).current.name != FavoriteSongsRoute.name) {
                // unable to test this without a large refactor ie. not worth the trouble
                // coverage:ignore-start
                await Future.microtask(() {
                  AutoRouter.of(context).popUntilRouteWithName(FavoriteSongsRoute.name);
                });
                // coverage:ignore-end
              }
            },
          ),
          ListTile(
            key: athensSongBook,
            title: const Text('Athens Songbook'),
            onTap: () {
              AutoRouter.of(context).push(PlaylistSongsRoute(playlistName: 'Athens Songbook'));
              Navigator.of(context).pop();
              timeDilation = 1;
            },
          ),
          ListTile(
            key: hymnal,
            title: const Text('Hymnal'),
            onTap: () {
              AutoRouter.of(context).push(PlaylistSongsRoute(playlistName: 'Hymnal'));
              Navigator.of(context).pop();
              timeDilation = 1;
            },
          ),
          ListTile(
            key: blueSongbook,
            title: const Text('Blue Songbook'),
            onTap: () {
              AutoRouter.of(context).push(PlaylistSongsRoute(playlistName: 'Blue Songbook'));
              Navigator.of(context).pop();
              timeDilation = 1;
            },
          ),
          ListTile(
            key: himnos,
            title: const Text('Himnos'),
            onTap: () {
              AutoRouter.of(context).push(PlaylistSongsRoute(playlistName: 'Himnos'));
              Navigator.of(context).pop();
              timeDilation = 1;
            },
          ),
          ListTile(
            key: liederbuch,
            title: const Text('Liederbuch'),
            onTap: () {
              AutoRouter.of(context).push(PlaylistSongsRoute(playlistName: 'Liederbuch'));
              Navigator.of(context).pop();
              timeDilation = 1;
            },
          ),
          ListTile(
            key: cantiques,
            title: const Text('Cantiques'),
            onTap: () {
              AutoRouter.of(context).push(PlaylistSongsRoute(playlistName: 'Cantiques'));
              Navigator.of(context).pop();
              timeDilation = 1;
            },
          ),
          const SizedBox(height: 25),
          const Divider(),
          ListTile(
            visualDensity: const VisualDensity(vertical: -3),
            dense: true,
            key: signOut,
            title: const Text(
              'Sign Out',
            ),
            onTap: () {
              ref.read(authNotifierProvider.notifier).signOut();
            },
          ),
          ListTile(
            dense: true,
            visualDensity: const VisualDensity(vertical: -3),
            key: deleteUser,
            title: const Text(
              'Delete Account',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              timeDilation = 1;
              // ignore: inference_failure_on_function_invocation
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Center(child: Text('Delete Account')),
                    content: const Text(
                      '⚡️DANGER!!⚡️\n\nAre you sure you want to delete your account?\nThis cannot be undone.\n\n⚡️DANGER!!⚡️',
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      TextButton(
                        key: yesDeleteUser,
                        onPressed: () {
                          ref.read(userRemoteServiceProvider).deleteUser();
                          ref.read(authNotifierProvider.notifier).signOut();
                          Navigator.of(context).pop();
                        },
                        child: const Text('YES'),
                      ),
                      TextButton(
                        key: noDeleteUser,
                        onPressed: () => Navigator.pop(context),
                        child: const Text('NO'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
