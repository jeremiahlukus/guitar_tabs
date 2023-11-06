// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:flutter_guitar_tabs/flutter_guitar_tabs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:joyful_noise/backend/core/domain/song.dart';
import 'package:joyful_noise/backend/core/shared/providers.dart';
import 'package:joyful_noise/backend/songs/song_detail/presentation/audio_control_buttons.dart';
import 'package:joyful_noise/backend/songs/song_detail/presentation/common_audio.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';

/// Encode [params] so it produces a correct query string.
/// Workaround for: https://github.com/dart-lang/sdk/issues/43838

// coverage:ignore-start
String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}
// coverage:ignore-end

@RoutePage()
class SongDetailPage extends ConsumerStatefulWidget {
  final Song song;
  const SongDetailPage({
    required this.song,
    super.key,
  });

  @override
  SongDetailPageState createState() => SongDetailPageState();
}

class SongDetailPageState extends ConsumerState<SongDetailPage> {
  final chordStyle = const TextStyle(fontSize: 20);
  final textStyle = const TextStyle(fontSize: 18);
  int transposeIncrement = 0;
  int scrollSpeed = 0;
  int scrollSpeedUI = 0;
  bool hideChords = false;
  final scrollController = ScrollController();
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

  @visibleForTesting
  static const hideChordsKey = ValueKey('hideTextKey');

  @override
  void initState() {
    Future.microtask(() {
      ref.read(songDetailNotifierProvider.notifier).getSongDetail(widget.song.id);
    });

    _init().catchError(
      // coverage:ignore-start
      (Object e) => Sentry.captureException(e, stackTrace: StackTrace.current),
      // coverage:ignore-end
    );
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
      }
    } catch (e) {
      await Sentry.captureException(e, stackTrace: StackTrace.current);
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
    // this code is setting up an auto-scroll behavior that, when the
    // user stops scrolling upwards, it automatically continues scrolling
    // downwards at a specified speed until it reaches the end of the scroll view.
    // coverage:ignore-start
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScrollDirection? lastDirection;
      scrollController.addListener(() {
        lastDirection = scrollController.position.userScrollDirection;
      });
      scrollController.position.isScrollingNotifier.addListener(() {
        //  If scrollController has stopped, and the last scroll direction
        //  was reverse (upwards), it calculates the remaining scroll extent
        // (extentToGo) and the time it should take to scroll to the end at the
        // current scrollSpeed
        if (!scrollController.position.isScrollingNotifier.value) {
          if (scrollSpeed > 0 && scrollController.hasClients && lastDirection == ScrollDirection.reverse) {
            final extentToGo = scrollController.position.maxScrollExtent - scrollController.offset;
            final seconds = (extentToGo / scrollSpeed).floor();
            try {
              // We know this will error since scrollController.hasClients is true at this point
              // To avoid Failed assertion '_hold == null || _drag == null'
              // We need to stop the scrolling by calling jumpTo with the current scroll position.
              // This will effectively stop the scrolling animation.
              // Then we start it again
              scrollController
                ..jumpTo(scrollController.offset)
                ..animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: Duration(seconds: seconds),
                  curve: Curves.linear,
                );
            } catch (e) {
              Sentry.captureException(e, stackTrace: StackTrace.current);
            }
          }
        }
      });
    });
    // coverage:ignore-end
    final state = ref.watch(songDetailNotifierProvider);
    // Not going to test url launcher
    // coverage:ignore-start
    void composeMail() {
      final emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'jeremiahlukus1@gmail.com',
        query: encodeQueryParameters(
          <String, String>{
            'subject': 'Joyful Noise | Song ID: ${widget.song.id}',
            'body':
                'Please X a box: \nIncorect Chords[]\n  Incorrect Song Url[]\n Incorrect Lyrics[]\n Other[] \n\n Song url: ${widget.song.url} \n\n Lyrics:  ${widget.song.lyrics}',
          },
        ),
      );
      launchUrl(emailLaunchUri);
    }

    // coverage:ignore-end
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        actions: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      // const SizedBox(width: 5),
                      Text('$transposeIncrement'),
                      // const SizedBox(width: 5),
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
                  const Text('Transpose'),
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
                                  if (scrollSpeed > 5) {
                                    scrollSpeedUI -= 1;
                                    scrollSpeed = scrollSpeed - 6;
                                  }
                                });
                                // coverage:ignore-end
                              },
                        child: const Text('-'),
                      ),
                      // const SizedBox(width: 5),
                      Text('$scrollSpeedUI'),
                      // const SizedBox(width: 5),
                      ElevatedButton(
                        key: scrollSpeedIncrementKey,
                        onPressed: () {
                          setState(() {
                            scrollSpeedUI += 1;
                            scrollSpeed = scrollSpeed + 6;
                          });
                        },
                        child: const Text('+'),
                      ),
                    ],
                  ),
                  const Text('Auto Scroll'),
                ],
              ),
              const SizedBox(width: 20),
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
                    key: favoriteKey,
                    onPressed: !state.songDetail.isFresh
                        ? null
                        : () {
                            ref.read(songDetailNotifierProvider.notifier).switchStarredStatus(state.songDetail.entity!);
                            ref.refresh(favoriteSongsNotifierProvider.notifier).getFirstFavoriteSongsPage();
                          },
                    icon: state.songDetail.entity?.isFavorite ?? true
                        ? const Icon(Icons.star)
                        : const Icon(Icons.star_outline),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: InteractiveViewer(
        panEnabled: false,
        minScale: 0.01,
        boundaryMargin: const EdgeInsets.all(80),
        maxScale: 4,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: LyricsRenderer(
                  scrollController: scrollController,
                  trailingWidget: Align(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: ElevatedButton(
                        onPressed: composeMail,
                        child: const Text('Suggest Changes'),
                      ),
                    ),
                  ),
                  widgetPadding: 50,
                  lyrics: widget.song.lyrics,
                  textStyle: Theme.of(context).textTheme.bodyMedium!,
                  chordStyle: !hideChords ? Theme.of(context).textTheme.labelMedium! : const TextStyle(fontSize: 0),
                  onTapChord: (String chord) async {
                    final tabs = await ref.read(songDetailNotifierProvider.notifier).getChordTabs(chord);
                    if (tabs.first != '') {
                      if (!context.mounted) return;
                      return showDialog<void>(
                        context: context,
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
                                  ),
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
                      ElevatedButton(
                        key: hideChordsKey,
                        onPressed: () {
                          setState(() {
                            hideChords = !hideChords;
                          });
                        },
                        child: !hideChords ? const Text('Hide Chords') : const Text('Show Chords'),
                      ),
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
                      widget.song.songNumber != 0
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              child: AutoSizeText(
                                'Song Number: ${widget.song.songNumber}',
                                maxLines: 1,
                                style: textStyle,
                              ),
                            )
                          : Container(),
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
            ),
          ],
        ),
      ),
    );
  }
}
