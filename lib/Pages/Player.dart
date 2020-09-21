import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

import 'package:provider/provider.dart';

class PlayerValue {
  PlayerValue({
    this.isPlaying,
    this.currentTime,
    this.bufferedTime,
    this.videoLength,
  });

  bool isPlaying;
  int currentTime;
  int bufferedTime;
  int videoLength;

  PlayerValue copyWith({
    bool isPlaying,
    int currentTime,
    int bufferedTime,
    int videoLength,
  }) {
    return PlayerValue(
      isPlaying: isPlaying ?? this.isPlaying,
      currentTime: currentTime ?? this.currentTime,
      bufferedTime: bufferedTime ?? this.bufferedTime,
      videoLength: videoLength ?? this.videoLength,
    );
  }
}

class Player extends ValueNotifier<PlayerValue> {

  static const playerChannel = const MethodChannel('com.example.app/player');

  Player() : super(PlayerValue());

  Future<int> initialize() async {
    value = value.copyWith(
      currentTime: 1,
      bufferedTime: 1,
      videoLength: 1,
      isPlaying: true,
    );
    return 1;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> play() async {
    final bool result = await playerChannel.invokeMethod('play');

    value.isPlaying = true;

    return result;
  }

  Future<bool> pause() async {
    final bool result = await playerChannel.invokeMethod('pause');

    value.isPlaying = false;

    return result;
  }

  int getCurrentTime() {
    return value.currentTime;
  }
}

String _printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

class ProgressBar extends StatefulWidget {
  ProgressBar(this.controller) : super();
  final Player controller;

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  _ProgressBarState() {
    _listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  Player get controller => widget.controller;

  VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    controller.addListener(_listener);
  }

  @override
  void deactivate() {
    controller.removeListener(_listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 53),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Stack(fit: StackFit.passthrough, children: <Widget>[
                LinearProgressIndicator(
                  value: controller.value.bufferedTime /
                      controller.value.videoLength,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                LinearProgressIndicator(
                  value: controller.value.currentTime /
                      controller.value.videoLength,
                  backgroundColor: Colors.transparent,
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _printDuration(
                          Duration(milliseconds: controller.value.currentTime)),
                      style: TextStyle(color: Colors.pink),
                    )),
                    Expanded(
                        child: Text(
                      _printDuration(
                          Duration(milliseconds: controller.value.videoLength)),
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.pink),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
