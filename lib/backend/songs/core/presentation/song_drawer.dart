// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:websafe_svg/websafe_svg.dart';

// Project imports:
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';

class SongDrawer extends ConsumerWidget {
  const SongDrawer({Key? key}) : super(key: key);
  static const drawerKey = ValueKey('drawerKey');
  static const athensSongBook = ValueKey('athensSongBook');
  static const hymnal = ValueKey('hymnal');
  static const blueSongbook = ValueKey('blueSongbook');
  static const himnos = ValueKey('himnos');
  static const liederbuch = ValueKey('liederbuch');
  static const cantiques = ValueKey('cantiques');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      key: drawerKey,
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
    );
  }
}
