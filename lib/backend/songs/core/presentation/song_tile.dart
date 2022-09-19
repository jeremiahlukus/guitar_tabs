// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';

class SongTile extends StatelessWidget {
  final Song song;

  const SongTile({Key? key, required this.song}) : super(key: key);

  static const favoriteSongButtonKey = ValueKey('favoriteSongButtonKey');
  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: favoriteSongButtonKey,
      onTap: () {
        AutoRouter.of(context).push(
          SongDetailRoute(song: song),
        );
      },
      title: Text(song.title),
      subtitle: Text(
        song.artist,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      // trailing: const Icon(
      //   // maybe add a fav count?
      //   FontAwesomeIcons.star,
      // ),
    );
  }
}
