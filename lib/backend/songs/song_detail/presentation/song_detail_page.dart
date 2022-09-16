// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:joyful_noise/auth/shared/providers.dart';
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/core/presentation/paginated_songs_list_view.dart';
import 'package:joyful_noise/core/presentation/routes/app_router.gr.dart';
import 'package:joyful_noise/core/shared/providers.dart';
import 'package:joyful_noise/search/presentation/search_bar.dart';
import 'package:shimmer/shimmer.dart';

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
                onPressed: () {},
              );
            },
          )
        ],
      ),
    );
  }
}
