// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:flutter_guitar_tabs/flutter_guitar_tabs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/song_detail/infrastructure/song_detail_remote_service.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';

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

  final chordStyle = const TextStyle(fontSize: 20);
  final textStyle = const TextStyle(fontSize: 18);
  int transposeIncrement = 0;
  int scrollSpeed = 0;

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
              return ElevatedButton.icon(
                label: const Text('Favorite'),
                onPressed: !state.songDetail.isFresh
                    ? null
                    : () {
                        ref.read(songDetailNotifierProvider.notifier).switchStarredStatus(state.songDetail.entity!);
                        ref.refresh(favoriteSongsNotifierProvider.notifier).getFirstFavoriteSongsPage();
                      },
                icon: state.songDetail.entity?.isFavorite == true
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_outline),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            transposeIncrement--;
                          });
                        },
                        child: const Text('-'),
                      ),
                      const SizedBox(width: 5),
                      Text('$transposeIncrement'),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            transposeIncrement++;
                          });
                        },
                        child: const Text('+'),
                      ),
                    ],
                  ),
                  const Text('Transpose')
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: scrollSpeed <= 0
                            ? null
                            : () {
                                setState(() {
                                  scrollSpeed--;
                                });
                              },
                        child: const Text('-'),
                      ),
                      const SizedBox(width: 5),
                      Text('$scrollSpeed'),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            scrollSpeed++;
                          });
                        },
                        child: const Text('+'),
                      ),
                    ],
                  ),
                  const Text('Auto Scroll')
                ],
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: LyricsRenderer(
                lyrics: widget.song.lyrics,
                textStyle: Theme.of(context).textTheme.bodyMedium!,
                chordStyle: Theme.of(context).textTheme.titleMedium!,
                onTapChord: (String chord) async {
                  final tabs = await SongDetailRemoteService(Dio()).getSongTabs(chord);
                  logger.e(tabs);
                  if (tabs.isNotEmpty) {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Center(
                                  child: TabWidget(
                                    name: chord,
                                    tabs: tabs,
                                    size: 4,
                                  ),
                                )
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Continue'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                transposeIncrement: transposeIncrement,
                scrollSpeed: scrollSpeed,
                widgetPadding: 50,
                lineHeight: 4,
                horizontalAlignment: CrossAxisAlignment.start,
                leadingWidget: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Text(
                    'Title: ${widget.song.title}',
                    style: chordStyle,
                  ),
                ),
                trailingWidget: widget.song.url.isNotEmpty
                    ? TextButton(
                        child: Text(
                          'Listen now',
                          style: chordStyle,
                        ),
                        onPressed: () {},
                      )
                    : Container(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
