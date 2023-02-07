// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:flutter_guitar_tabs/flutter_guitar_tabs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shimmer/shimmer.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/song_detail/presentation/audio_control_buttons.dart';
import 'package:joyful_noise/backend/songs/song_detail/presentation/common_audio.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';

class SongDetailPage extends ConsumerStatefulWidget {
  final Song song;
  const SongDetailPage({Key? key, required this.song}) : super(key: key);

  @override
  SongDetailPageState createState() => SongDetailPageState();
}

class SongDetailPageState extends ConsumerState<SongDetailPage> {
  final chordStyle = const TextStyle(fontSize: 20);
  final textStyle = const TextStyle(fontSize: 18);
  int transposeIncrement = 0;
  int scrollSpeed = 0;
  final _player = AudioPlayer();

  @visibleForTesting
  static const transposeIncrementKey = ValueKey('transposeIncrement');
  @visibleForTesting
  static const transposeDecrementKey = ValueKey('transposeDecrement');

  @visibleForTesting
  static const scrollSpeedIncrementKey = ValueKey('scrollSpeedIncrement');

  @visibleForTesting
  static const scrollSpeedDecrementKey = ValueKey('scrollSpeedDecrement');

  @visibleForTesting
  static const favoriteKey = ValueKey('favorite');

  @override
  void initState() {
    ref.read(songDetailNotifierProvider.notifier).getSongDetail(widget.song.id);
    _init().catchError((dynamic e) => logger.e(e));
    super.initState();
  }

  @override
  void dispose() {
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    // Listen to errors during playback.
    _player.playbackEventStream.listen(
      (event) {},
      // coverage:ignore-start
      onError: (Object e, StackTrace stackTrace) {
        logger.e('A stream error occurred: $e');
      },
      // coverage:ignore-end
    );
    // Try to load audio from a source and catch any errors.
    try {
      // coverage:ignore-start
      // golden test break setting the audio source
      if (widget.song.url.isNotEmpty && !Platform.environment.containsKey('FLUTTER_TEST')) {
        await _player.setAudioSource(AudioSource.uri(Uri.parse(widget.song.url)));
        logger.i(widget.song.url);
      }
    } catch (e) {
      logger.e('Error loading audio source: $e');
    }
    // coverage:ignore-end
  }

  Stream<PositionData> get _positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
        // coverage:ignore-start
        (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero),
        // coverage:ignore-end
      );

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
                key: favoriteKey,
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
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              child: LyricsRenderer(
                widgetPadding: 50,
                lyrics: widget.song.lyrics,
                textStyle: Theme.of(context).textTheme.bodyMedium!,
                chordStyle: Theme.of(context).textTheme.titleSmall!,
                onTapChord: (String chord) async {
                  final tabs = await ref.read(songDetailNotifierProvider.notifier).getChordTabs(chord);
                  if (tabs!.isNotEmpty && tabs.first != '') {
                    // ignore: use_build_context_synchronously
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
                lineHeight: 4,
                horizontalAlignment: CrossAxisAlignment.start,
                leadingWidget: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                ElevatedButton(
                                  key: transposeDecrementKey,
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
                                  key: transposeIncrementKey,
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
                                  key: scrollSpeedDecrementKey,
                                  onPressed: scrollSpeed <= 0
                                      ? null
                                      // coverage:ignore-start
                                      : () {
                                          setState(() {
                                            scrollSpeed = scrollSpeed - 2;
                                          });
                                          // coverage:ignore-end
                                        },
                                  child: const Text('-'),
                                ),
                                const SizedBox(width: 5),
                                Text('$scrollSpeed'),
                                const SizedBox(width: 5),
                                ElevatedButton(
                                  key: scrollSpeedIncrementKey,
                                  onPressed: () {
                                    setState(() {
                                      scrollSpeed = scrollSpeed + 6;
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: AutoSizeText(
                        widget.song.title,
                        maxLines: 1,
                        style: chordStyle,
                      ),
                    ),
                    widget.song.url.isNotEmpty
                        ? Column(
                            children: [
                              ControlButtons(_player),
                              StreamBuilder<PositionData>(
                                stream: _positionDataStream,
                                builder: (context, snapshot) {
                                  final positionData = snapshot.data;

                                  return SeekBar(
                                    // coverage:ignore-start
                                    duration: positionData?.duration ?? Duration.zero,
                                    position: positionData?.position ?? Duration.zero,
                                    bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
                                    onChangeEnd: _player.seek,
                                    // coverage:ignore-end
                                  );
                                },
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
