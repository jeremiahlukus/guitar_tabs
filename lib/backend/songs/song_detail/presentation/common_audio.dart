// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  @visibleForTesting
  static const seekbarKey = ValueKey('seekbarKey');

  const SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
    super.key,
  });

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: Colors.blue.shade100,
            inactiveTrackColor: Colors.grey.shade300,
          ),
          child: ExcludeSemantics(
            child: Slider(
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(widget.bufferedPosition.inMilliseconds.toDouble(), widget.duration.inMilliseconds.toDouble()),
              // coverage:ignore-start
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  // ignore: prefer_null_aware_method_calls
                  widget.onChanged!(Duration(milliseconds: value.round()));
                  // coverage:ignore-end
                }
              },
              // coverage:ignore-start
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  // ignore: prefer_null_aware_method_calls
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
              // coverage:ignore-end
            ),
          ),
        ),
        // The blue dot
        SliderTheme(
          data: _sliderThemeData.copyWith(
            inactiveTrackColor: Colors.transparent,
          ),
          child: Slider(
            key: SeekBar.seekbarKey,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(
              _dragValue ?? widget.position.inMilliseconds.toDouble(),
              widget.duration.inMilliseconds.toDouble(),
            ),
            // coverage:ignore-start
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                // ignore: prefer_null_aware_method_calls
                widget.onChanged!(Duration(milliseconds: value.round()));
                // coverage:ignore-end
              }
            },
            // coverage:ignore-start
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                // ignore: prefer_null_aware_method_calls
                widget.onChangeEnd!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
            // coverage:ignore-end
          ),
        ),
        Positioned(
          right: 16,
          bottom: 0,
          child: Text(
            RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$').firstMatch('$_remaining')?.group(1) ??
                // coverage:ignore-start
                '$_remaining',
            // coverage:ignore-end
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
// coverage:ignore-start
  PositionData(this.position, this.bufferedPosition, this.duration);
  // coverage:ignore-end
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
  String valueSuffix = '',
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => SizedBox(
          height: 100,
          child: Column(
            children: [
              Text(
                '${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                style: const TextStyle(fontFamily: 'Fixed', fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// coverage:ignore-start
T? ambiguate<T>(T? value) => value;
// coverage:ignore-end
