// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// Project imports:
import 'package:joyful_noise/core/presentation/bootstrap.dart';
import 'package:joyful_noise/core/presentation/styles/hex_to_color.dart';

@RoutePage()
class TunerPage extends StatefulWidget {
  const TunerPage({super.key});

  @override
  State<TunerPage> createState() => _TunerPageState();
}

class _TunerPageState extends State<TunerPage> {
  final _audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(44100, 2000);
  final pitchupDart = PitchHandler(InstrumentType.guitar);

  String note = '';
  String status = 'Click on start';

  Future<void> _startCapture() async {
    await _audioRecorder.start(listener, onError, sampleRate: 44100, bufferSize: 3000);
    setState(() {
      note = '';
      status = 'Play something';
    });
  }

  @override
  void initState() {
    _startCapture();
    super.initState();
  }

  @override
  void dispose() {
    _audioRecorder.stop();
    super.dispose();
  }

  SfRadialGauge _buildRadialGauge() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          showLabels: false,
          showAxisLine: false,
          showTicks: false,
          maximum: 99,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0, endValue: 33,
              // color: const Color(0xFFFE2A25),
              label: 'Low',
              gradient: const SweepGradient(colors: <Color>[Color(0xFFACB6E5)], stops: <double>[0.25]),
              sizeUnit: GaugeSizeUnit.factor,
              labelStyle: GaugeTextStyle(color: HexColor('#333333'), fontSize: 20),
              startWidth: 0.40, endWidth: 0.40,
            ),
            GaugeRange(
              startValue: 33, endValue: 66,
              // color:const Color(0xFFFFBA00),
              label: 'Tuned',
              gradient: const SweepGradient(
                colors: <Color>[Color(0xFFACB6E5), Color(0xFF74ebd5)],
                stops: <double>[0.25, 0.75],
              ),
              labelStyle: GaugeTextStyle(color: HexColor('#333333'), fontSize: 20),
              startWidth: 0.40, endWidth: 0.40,
              sizeUnit: GaugeSizeUnit.factor,
            ),
            GaugeRange(
              startValue: 66, endValue: 99,
              // color:const Color(0xFF00AB47),
              label: 'High',
              gradient: const SweepGradient(colors: <Color>[Color(0xFF74ebd5)], stops: <double>[0.75]),
              labelStyle: GaugeTextStyle(color: HexColor('#333333'), fontSize: 20),
              sizeUnit: GaugeSizeUnit.factor,
              startWidth: 0.40, endWidth: 0.40,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: status == 'TuningStatus.waytoolow'
                  ? 20
                  : status == 'TuningStatus.toolow'
                      ? 40
                      : status == 'TuningStatus.tuned'
                          ? 50
                          : status == 'TuningStatus.toohigh'
                              ? 60
                              : status == 'TuningStatus.waytoohigh'
                                  ? 80
                                  : 0,
              needleEndWidth: 5,
              needleColor: Colors.black,
              knobStyle: const KnobStyle(
                knobRadius: 0.09,
                borderColor: Colors.white,
                borderWidth: 0.02,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _stopCapture() async {
    await _audioRecorder.stop();
    setState(() {
      note = '';
      status = 'Click on start';
    });
  }

  void listener(dynamic obj) {
    //Gets the audio sample
    // ignore: avoid_dynamic_calls
    final buffer = Float64List.fromList(obj.cast<double>() as List<double>);
    final audioSample = buffer.toList();

    //Uses pitch_detector_dart library to detect a pitch from the audio sample
    final result = pitchDetectorDart.getPitch(audioSample);

    //If there is a pitch - evaluate it
    if (result.pitched) {
      //Uses the pitchupDart library to check a given pitch for a Guitar
      final handledPitchResult = pitchupDart.handlePitch(result.pitch);

      //Updates the state with the result
      setState(() {
        note = handledPitchResult.note;
        status = handledPitchResult.tuningStatus.toString();
      });
    }
  }

  void onError(Object e) {
    logger.e('ERROR:  $e');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Center(
              child: Text(
                'Guitar Tuner',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            Center(
              child: Text(
                note,
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            _buildRadialGauge(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: FloatingActionButton(
                        onPressed: _startCapture,
                        heroTag: 'start',
                        child: Text(
                          'Start',
                          style: TextStyle(
                            color: HexColor('#333333'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: FloatingActionButton(
                        onPressed: _stopCapture,
                        heroTag: 'stop',
                        child: Text(
                          'Stop',
                          style: TextStyle(
                            color: HexColor('#333333'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
