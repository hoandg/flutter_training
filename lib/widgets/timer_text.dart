import 'dart:async';

import 'package:countdown_poker/models/elapsed_time.dart';
import 'package:flutter/material.dart';

class TimerText extends StatefulWidget {
  const TimerText({super.key, required this.minutes});
  final double minutes;

  @override
  State<StatefulWidget> createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  int _minutes = 0;
  int _seconds = 0;
  // Stopwatch stopwatch = Stopwatch();
  late Timer timer;
  late int milliseconds;

  @override
  void initState() {
    super.initState();
    calculateTime();
    timer =
        Timer(Duration(minutes: _minutes, seconds: _seconds), () => callback);
  }

  @override
  void didUpdateWidget(covariant TimerText oldWidget) {
    super.didUpdateWidget(oldWidget);
    calculateTime();
  }

  void calculateTime() {
    setState(() {
      if (widget.minutes <= 1) {
        _seconds = (widget.minutes * 60).toInt();
      } else {
        _seconds = ((widget.minutes * 60) % 60).toInt();
        _minutes = (widget.minutes).floor();
      }
    });
  }

  void callback(Timer timer) {
    // if (stopwatch.isRunning) {
    //   setState(() {
    //     milliseconds = stopwatch.elapsedMicroseconds;
    //   });
    // }
  }

  // void _onTick(ElapsedTime elapsedTime) {
  //   if (elapsedTime.minutes != _minutes)
  // }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (_minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (_seconds % 60).toString().padLeft(2, '0');
    return Text(
      "$minutesStr : $secondsStr",
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
    );
  }
}
