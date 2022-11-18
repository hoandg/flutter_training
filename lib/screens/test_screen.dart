import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late Stopwatch playerWatch;
  late Stopwatch blindWatch;

  late int minutes;
  late int seconds;

  @override
  void initState() {
    super.initState();
    playerWatch = Stopwatch();

    minutes = 10;
    seconds = 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${minutes.toString()} : ${seconds.toString()}"),
      ),
    );
  }
}
