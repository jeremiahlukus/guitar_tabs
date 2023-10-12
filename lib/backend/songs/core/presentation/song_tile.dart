// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.dart';

class SongTile extends StatelessWidget {
  final Song song;

  const SongTile({
    required this.song,
    super.key,
  });

  static const songDetailButtonKey = ValueKey('songDetailButtonKey');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          key: songDetailButtonKey,
          onTap: () {
            AutoRouter.of(context).push(
              SongDetailRoute(song: song),
            );
          },
          title: Text(song.title),
        ),
        const Divider(
          thickness: 5,
        ),
      ],
    );
  }
}
