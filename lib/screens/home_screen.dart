import 'package:countdown_poker/models/setting.dart';
import 'package:countdown_poker/routes.dart';
import 'package:countdown_poker/widgets/timer_text.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Setting setting;
  bool isPlayerTimeStoped = true;
  bool isRunning = false;
  bool isStop = false;
  bool isReset = false;
  GetStorage box = GetStorage();

  @override
  void initState() {
    super.initState();
    setting = _loadFromStorage();
  }

  Setting _loadFromStorage() {
    Setting newSetting = Setting.defaultConstructor();
    if (box.hasData("setting")) {
      try {
        newSetting = box.read("setting");
      } catch (e) {
        box.remove("setting");
      }
    }

    return newSetting;
  }

  void _navigateToSetting() async {
    await Navigator.of(context).pushNamed(Routes.SETTING);

    setState(() {
      setting = _loadFromStorage();
    });
  }

  void _startAction() {
    setState(() {
      isPlayerTimeStoped = false;
    });
  }

  void _stopPlayerTime() {
    setState(() {
      if (isPlayerTimeStoped) {
        isPlayerTimeStoped = false;
      } else {
        isPlayerTimeStoped = true;
      }
    });
  }

  void _resetPlayerTime() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Poker countdown"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(children: [
            Row(
              children: [
                ElevatedButton(
                    onPressed: () => _startAction(),
                    child: const Text('Start')),
                Expanded(
                  child: Center(
                    child: Text(
                      "Current blind level: ${setting.smallBlind} / ${setting.bigBlind}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.blue),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _navigateToSetting(),
                  icon: const Icon(Icons.settings),
                )
              ],
            ),
            const SizedBox(height: 64),
            Center(
              child: TimerText(
                minutes: setting.playerTimer,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text(isPlayerTimeStoped ? "Stop" : "Resume"),
                    onPressed: () => _stopPlayerTime(),
                  ),
                ),
                const SizedBox(width: 8 * 16),
                Expanded(
                  child: ElevatedButton(
                      child: const Text("Reset"),
                      onPressed: () => _resetPlayerTime()),
                )
              ],
            ),
            const SizedBox(height: 64),
            Center(
              child: TimerText(
                minutes: setting.blindTimer,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
