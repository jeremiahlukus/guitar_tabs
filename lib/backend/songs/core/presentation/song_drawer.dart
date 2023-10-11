// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:websafe_svg/websafe_svg.dart';

// Project imports:
import 'package:joyful_noise/auth/shared/providers.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';

class SongDrawer extends ConsumerWidget {
  const SongDrawer({super.key});
  static const drawerKey = ValueKey('drawerKey');
  static const athensSongBook = ValueKey('athensSongBook');
  static const hymnal = ValueKey('hymnal');
  static const blueSongbook = ValueKey('blueSongbook');
  static const himnos = ValueKey('himnos');
  static const liederbuch = ValueKey('liederbuch');
  static const cantiques = ValueKey('cantiques');
  static const deleteUser = ValueKey('deleteUser');
  static const noDeleteUser = ValueKey('noDeleteUser');
  static const yesDeleteUser = ValueKey('yesDeleteUser');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      key: drawerKey,
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Column(
        // Important: Remove any padding from the ListView.
        // padding: EdgeInsets.zero,
        children: [
          Expanded(
            child: Column(
              children: [
                DrawerHeader(
                  child: WebsafeSvg.asset('assets/logo.svg'),
                ),
                ListTile(
                  key: athensSongBook,
                  title: const Text('Athens Songbook'),
                  onTap: () {
                    AutoRouter.of(context).push(PlaylistSongsRoute(playlistName: 'Athens Songbook'));
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  key: hymnal,
                  title: const Text('Hymnal'),
                  onTap: () {
                    AutoRouter.of(context).push(PlaylistSongsRoute(playlistName: 'Hymnal'));
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  key: blueSongbook,
                  title: const Text('Blue Songbook'),
                  onTap: () {
                    AutoRouter.of(context).push(PlaylistSongsRoute(playlistName: 'Blue Songbook'));
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  key: himnos,
                  title: const Text('Himnos'),
                  onTap: () {
                    AutoRouter.of(context).push(PlaylistSongsRoute(playlistName: 'Himnos'));
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  key: liederbuch,
                  title: const Text('Liederbuch'),
                  onTap: () {
                    AutoRouter.of(context).push(PlaylistSongsRoute(playlistName: 'Liederbuch'));
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  key: cantiques,
                  title: const Text('Cantiques'),
                  onTap: () {
                    AutoRouter.of(context).push(PlaylistSongsRoute(playlistName: 'Cantiques'));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          // Put delete Account at bottom of drawer
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              children: [
                const Divider(),
                ListTile(
                  key: deleteUser,
                  title: const Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
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
          ),
        ],
      ),
    );
  }
}
