// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';

class SongTile extends StatelessWidget {
  final Song song;
  const SongTile({Key? key, required this.song}) : super(key: key);

  static const favoriteSongButtonKey = ValueKey('favoriteSongButtonKey');
  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: favoriteSongButtonKey,
      onTap: () {},
      title: Text(song.title),
      subtitle: Text(
        song.artist,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.star_border),
    );
  }
}
