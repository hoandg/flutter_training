import 'dart:async';
import 'package:flutter/material.dart';

class TimerText extends StatefulWidget {
  const TimerText(
      {super.key,
      required this.minutes,
      this.isRunning,
      this.isPause,
      this.isReset,
      required this.successMsg});
  final double minutes;
  final bool? isRunning;
  final bool? isPause;
  final bool? isReset;
  final String successMsg;

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
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  void didUpdateWidget(covariant TimerText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRunning!) {
      timer = Timer.periodic(
          const Duration(seconds: 1), (timer) => callback(timer));
    }
    if (widget.isPause!) {
      timer.cancel();
    }
    if (widget.isReset!) {
      calculateTime();
    }
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
    if (widget.isRunning!) {
      if (_seconds > 0) {
        setState(() {
          _seconds = _seconds - 1;
        });
      } else if (_minutes > 0) {
        setState(() {
          _minutes = _minutes - 1;
          _seconds = 60;
        });
      } else {
        calculateTime();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(widget.successMsg)));
      }
    }
  }

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
