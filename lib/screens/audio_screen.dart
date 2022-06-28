
import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../models/qari.dart';
import '../models/surah.dart';
import '../style.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen(
      {Key? key, required this.qari, required this.index, required this.list})
      : super(key: key);
  final Qari qari;
  final int index;
  final List<Surah> list;

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final player = AudioPlayer();
  bool isLoopingCurrentItems = false;
  Duration defaultDuration = const Duration(milliseconds: 1);
  String? indexX;
  int currentIndex = 0;
  int dataIndex = 0;

  @override
  void initState() {
    setState(() {
      currentIndex = widget.index - 1;
      dataIndex = widget.index - 1;
    });
    if (widget.index < 10) {
      indexX = '00' + widget.index.toString();
    } else if (widget.index < 100) {
      indexX = '0' + widget.index.toString();
    } else if (widget.index >= 100) {
      indexX = widget.index.toString();
    }
    initAudioPlayer(indexX!, widget.qari);
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      player.stop();
    }
  }

  void handleLooping() async {
    if (isLoopingCurrentItems) {
      await player.setLoopMode(LoopMode.one);
    } else {
      await player.setLoopMode(LoopMode.off);
    }
    setState(() {
      isLoopingCurrentItems = !isLoopingCurrentItems;
    });
  }

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Now Playing',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                width: sizeFromWidth(context, 1),
                height: sizeFromHeight(context, 2.8,hasAppBar: true),
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Constants.kPrimary,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1,
                          offset: Offset(0, 2),
                          color: Colors.black12),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.list[currentIndex].arabicName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Total Ayah : ${widget.list[currentIndex].numberOfAyahs}',
                      style: const TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(height: sizeFromHeight(context, 20,hasAppBar: true)),
              StreamBuilder<PositionData>(
                stream: positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? defaultDuration,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChanged: player.seek,
                  );
                },
              ),
              SizedBox(height: sizeFromHeight(context, 50,hasAppBar: true)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        if (currentIndex > 0) {
                          setState(() {
                            dataIndex = currentIndex;
                            currentIndex--;
                          });
                          if (dataIndex < 10) {
                            indexX = "00" + (dataIndex.toString());
                          } else if (dataIndex < 100) {
                            indexX = "0" + (dataIndex.toString());
                          } else if (dataIndex >= 100) {
                            indexX = (dataIndex.toString());
                          }
                          initAudioPlayer(indexX!, widget.qari);
                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.stepBackward,
                        color: Colors.black,
                        size: MediaQuery.of(context).size.width * 0.05,
                      )),
                  StreamBuilder<PlayerState>(
                    stream: player.playerStateStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      final processingState = playerState?.processingState;
                      final playing = playerState?.playing;
                      if (processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering) {
                        return Container(
                            decoration: BoxDecoration(
                              color: Constants.kPrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const SpinKitRipple(
                              color: Colors.black,
                              duration: Duration(milliseconds: 800),
                              //  size: _width * 0.24,
                            ));
                      } else if (playing != true) {
                        return InkWell(
                          onTap: player.play,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Constants.kPrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              FontAwesomeIcons.play,
                              color: Colors.black,
                              size: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        );
                      } else if (processingState !=
                          ProcessingState.completed) {
                        return InkWell(
                          onTap: player.pause,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Constants.kPrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              FontAwesomeIcons.pause,
                              color: Colors.black,
                              size: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        );
                      } else {
                        return InkWell(
                          onTap: () => player.seek(Duration.zero),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Constants.kPrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.shuffle,
                              color: Colors.black,
                              size: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      if (currentIndex >= 0 && currentIndex < 113) {
                        setState(() {
                          currentIndex++;
                          dataIndex = currentIndex + 1;
                        });
                        if (dataIndex < 10) {
                          indexX = "00" + (dataIndex.toString());
                        } else if (dataIndex < 100) {
                          indexX = "0" + (dataIndex.toString());
                        } else if (dataIndex > 100) {
                          indexX = (dataIndex.toString());
                        }
                        initAudioPlayer(indexX!, widget.qari);
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.stepForward,
                      color: Colors.black,
                      size: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.volume_up,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                    onPressed: () {
                      showSliderDialog(
                        context: context,
                        title: "Adjust Volume",
                        divisions: 10,
                        min: 0.0,
                        max: 1.0,
                        value: player.volume,
                        stream: player.volumeStream,
                        onChanged: player.setVolume,
                      );
                    },
                  ),
                  StreamBuilder<double>(
                    stream: player.speedStream,
                    builder: (context, snapshot) => IconButton(
                      icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      onPressed: () {
                        showSliderDialog(
                          context: context,
                          title: "Adjust Speed",
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
              ),
              SizedBox(height: sizeFromHeight(context, 50,hasAppBar: true)),
              currentIndex >= 113
                  ? Container()
                  : Expanded(
                      child: Container(
                        width: sizeFromWidth(context, 1),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: Offset(0, 1),
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'NEXT SURAH',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: sizeFromHeight(context, 60,hasAppBar: true)),
                              Visibility(
                                visible: (currentIndex <= 112) ? true : false,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.play_circle_fill,
                                      color: Constants.kPrimary,
                                    ),
                                    Text(
                                      widget.list[currentIndex + 1].arabicName,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20,fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: sizeFromHeight(context, 60,hasAppBar: true)),
                              Visibility(
                                visible: (currentIndex <= 111) ? true : false,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      currentIndex > 111
                                          ? null
                                          : Icons.play_circle_fill,
                                      color: Constants.kPrimary,
                                    ),
                                    Text(
                                      currentIndex > 111
                                          ? ''
                                          : widget.list[currentIndex + 2]
                                              .arabicName,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20,fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void initAudioPlayer(String index, Qari qari) async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      throw Exception('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      var url = "https://download.quranicaudio.com/quran/${qari.path}$index.mp3";
      defaultDuration =
          (await player.setAudioSource(AudioSource.uri(Uri.parse(url))))!;
    } catch (e) {
      throw Exception('Error loading audio source: $e');
    }
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;

  const SeekBar({Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
  }) : super(key: key);

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Constants.kPrimary,
            inactiveTrackColor: Colors.grey,
            trackHeight: 5.0,
            thumbColor: Constants.kPrimary,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            overlayColor: Colors.purple.withAlpha(32),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: sizeFromWidth(context, 30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                positionText,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              Text(
                durationText,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String get durationText =>
      "${widget.duration.inMinutes.remainder(60).toString().padLeft(2, '0')}"
      ":${widget.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";

  String get positionText =>
      "${widget.position.inMinutes.remainder(60).toString().padLeft(2, '0')}"
      ":${widget.position.inSeconds.remainder(60).toString().padLeft(2, '0')}";
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => SizedBox(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: const TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
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
