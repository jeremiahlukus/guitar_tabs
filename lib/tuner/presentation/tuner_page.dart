import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:joyful_noise/core/presentation/bootstrap.dart';
import 'package:joyful_noise/core/presentation/styles/hex_to_color.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TunerPage extends StatefulWidget {
  const TunerPage({super.key});

  @override
  State<TunerPage> createState() => _TunerPageState();
}

class _TunerPageState extends State<TunerPage> {
  final _audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(44100, 2000);
  PitchHandler pitchupDart = PitchHandler(InstrumentType.guitar);
  bool isAutoTune = true;
  String note = '';
  String status = 'Click on start';
  String selectedString = '';

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
              startValue: 0,
              endValue: 99,
              label: 'Tuned',
              labelStyle: GaugeTextStyle(color: HexColor('#333333'), fontSize: 20),
              gradient: const SweepGradient(
                colors: <Color>[Color(0xFFACB6E5), Color(0xFF86C5E7), Color(0xFF74ebd5)],
                stops: <double>[0, 0.5, 1],
              ),
              sizeUnit: GaugeSizeUnit.factor,
              startWidth: 0.40,
              endWidth: 0.40,
            ),
            GaugeRange(
              startValue: 0,
              endValue: 34,
              label: 'Low',
              labelStyle: GaugeTextStyle(color: HexColor('#333333'), fontSize: 20),
              color: Colors.transparent,
              sizeUnit: GaugeSizeUnit.factor,
              startWidth: 0.40,
              endWidth: 0.40,
            ),
            GaugeRange(
              startValue: 66,
              endValue: 99,
              label: 'High',
              labelStyle: GaugeTextStyle(color: HexColor('#333333'), fontSize: 20),
              color: Colors.transparent,
              sizeUnit: GaugeSizeUnit.factor,
              startWidth: 0.40,
              endWidth: 0.40,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              animationDuration: 2000,
              enableAnimation: true, // Enable the animation
              value: status == 'TuningStatus.wayTooLow'
                  ? 10
                  : status == 'TuningStatus.tooLow'
                      ? 20
                      : status == 'TuningStatus.slightlyLow'
                          ? 30
                          : status == 'TuningStatus.tuned'
                              ? 50
                              : status == 'TuningStatus.slightlyHigh'
                                  ? 60
                                  : status == 'TuningStatus.tooHigh'
                                      ? 70
                                      : status == 'TuningStatus.wayTooHigh'
                                          ? 90
                                          : 0,
              needleEndWidth: 5,
              needleColor: Theme.of(context).textTheme.bodyMedium!.color,
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

  void listener(dynamic obj) {
    // Gets the audio sample
    // ignore: avoid_dynamic_calls
    final buffer = Float64List.fromList(obj.cast<double>() as List<double>);
    final audioSample = buffer.toList();

    // Uses pitch_detector_dart library to detect a pitch from the audio sample
    final result = pitchDetectorDart.getPitch(audioSample);

    // If there is a pitch - evaluate it
    if (result.pitched) {
      logger.e('pitched');
      // Uses the pitchupDart library to check a given pitch for a Guitar
      final handledPitchResult = pitchupDart.handlePitch(result.pitch);
      logger.e(handledPitchResult.tuningStatus.toString());
      // Updates the state with the result
      setState(() {
        note = handledPitchResult.note;
        status = handledPitchResult.tuningStatus.toString();
      });
    }
  }

  void onError(Object e) {
    Sentry.captureException(e, stackTrace: StackTrace.current);
  }

  Widget _buildStringButton(String note, double padding) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).textTheme.bodyMedium!.color!, // Set border color
          width: 2, // Set border width
        ),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            isAutoTune = false;
            selectedString = note;
            pitchupDart = PitchHandler(InstrumentType.guitar, selectedNote: selectedString);
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Text(
            note,
            style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = screenWidth * 0.02;
    final horizontalPadding = padding + 40;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guitar Tuner'),
        actions: <Widget>[
          const Text('Manual'),
          Switch(
            value: isAutoTune,
            onChanged: (value) {
              setState(() {
                isAutoTune = value;
                if (isAutoTune) {
                  setState(() {
                    selectedString = '';
                    pitchupDart = PitchHandler(InstrumentType.guitar);
                  });
                } else {
                  setState(() {
                    selectedString = 'E2';
                    pitchupDart = PitchHandler(InstrumentType.guitar, selectedNote: 'E2');
                  });
                }
              });
            },
          ),
          const Text('Auto Detect'),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: Text(
                selectedString.isEmpty ? note : selectedString,
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Stack(
              children: <Widget>[
                _buildRadialGauge(),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.3), // 30% of screen height
                  child: Stack(
                    children: [
                      Align(
                        child: SizedBox(
                          height: screenHeight / 2.5,
                          width: screenWidth / 2.5,
                          child: Image.network(
                            'https://stuff.fendergarage.com/f-com/prod/fender-tuner/assets/tuner/img/paramount/bg-fc9aaea058f25df1786edebc8127c8df.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        top: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: horizontalPadding, bottom: padding, top: padding),
                                    child: _buildStringButton('D3', padding),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: horizontalPadding, bottom: padding, top: padding),
                                    child: _buildStringButton('A2', padding),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: horizontalPadding, bottom: padding, top: padding),
                                    child: _buildStringButton('E2', padding),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: horizontalPadding, bottom: padding, top: padding),
                                    child: _buildStringButton('G3', padding),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: horizontalPadding, bottom: padding, top: padding),
                                    child: _buildStringButton('B3', padding),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: horizontalPadding, bottom: padding, top: padding),
                                    child: _buildStringButton('E4', padding),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
