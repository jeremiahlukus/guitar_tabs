import 'package:flutter/material.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';

class SongTile extends StatelessWidget {
  final Song song;
  const SongTile({
    Key? key,
    required this.song,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
