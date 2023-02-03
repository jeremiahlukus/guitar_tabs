// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:just_audio/just_audio.dart';

// Project imports:
import 'package:joyful_noise/backend/songs/song_detail/presentation/common_audio.dart';

/// Displays the play/pause button and volume/speed sliders.
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @visibleForTesting
  static const playButton = ValueKey('playButton');

  @visibleForTesting
  static const pauseButton = ValueKey('pauseButton');

  @visibleForTesting
  static const replayButton = ValueKey('replayButton');

  @visibleForTesting
  static const speedButton = ValueKey('speedButton');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
              // coverage:ignore-start
              return Container(
                margin: const EdgeInsets.all(8),
                width: 64,
                height: 64,
                child: const CircularProgressIndicator(),
              );
              // coverage:ignore-end
            } else if (playing != true) {
              return IconButton(
                key: playButton,
                icon: const Icon(Icons.play_arrow),
                iconSize: 64,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                key: pauseButton,
                icon: const Icon(Icons.pause),
                iconSize: 64,
                onPressed: player.pause,
              );
            } else {
              // coverage:ignore-start
              return IconButton(
                key: replayButton,
                icon: const Icon(Icons.replay),
                iconSize: 64,
                onPressed: () => player.seek(Duration.zero),
              );
              // coverage:ignore-end
            }
          },
        ),
        // Opens speed slider dialog
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            key: speedButton,
            icon: Text(
              '${snapshot.data?.toStringAsFixed(1)}x',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: 'Adjust speed',
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}
