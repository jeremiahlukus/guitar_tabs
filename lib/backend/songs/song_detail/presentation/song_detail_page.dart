// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';

class SongDetailPage extends ConsumerStatefulWidget {
  final Song song;
  const SongDetailPage({Key? key, required this.song}) : super(key: key);

  @override
  SongDetailPageState createState() => SongDetailPageState();
}

class SongDetailPageState extends ConsumerState<SongDetailPage> {
  @override
  void initState() {
    ref.read(songDetailNotifierProvider.notifier).getSongDetail(widget.song.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(songDetailNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          state.maybeMap(
            orElse: () => Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade300,
              child: IconButton(
                icon: const Icon(Icons.star),
                onPressed: null,
                disabledColor: Theme.of(context).iconTheme.color,
              ),
            ),
            loadSuccess: (state) {
              return IconButton(
                icon: Icon(
                  state.songDetail.entity?.isFavorite == true ? Icons.star : Icons.star_outline,
                  color: state.songDetail.entity?.isFavorite == true ? Colors.red : Colors.grey,
                ),
                onPressed: !state.songDetail.isFresh
                    ? null
                    : () {
                        ref.read(songDetailNotifierProvider.notifier).switchStarredStatus(state.songDetail.entity!);
                      },
              );
            },
          )
        ],
      ),
    );
  }
}
