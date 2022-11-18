import 'package:countdown_poker/models/setting.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController smallBlindController = TextEditingController();
  final TextEditingController bigBlindController = TextEditingController();
  final TextEditingController playerTimerController = TextEditingController();
  final TextEditingController blindTimerController = TextEditingController();
  final GetStorage box = GetStorage();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Setting setting = Setting.defaultConstructor();
    if (box.hasData("setting")) {
      try {
        setting = box.read("setting");
      } catch (e) {
        box.remove("setting");
      }
    }

    smallBlindController.text = setting.smallBlind.toString();
    bigBlindController.text = setting.bigBlind.toString();
    playerTimerController.text = setting.playerTimer.toString();
    blindTimerController.text = setting.blindTimer.toString();
  }

  void _saveSetting() {
    if (_formKey.currentState!.validate()) {
      Setting setting = Setting.init();
      setting.setSmallBlind(int.parse(smallBlindController.text));
      setting.setBigBlind(int.parse(bigBlindController.text));
      setting.setPlayerTimer(double.parse(playerTimerController.text));
      setting.setBlindTimer(double.parse(blindTimerController.text));

      if (box.hasData("setting")) box.remove("setting");
      box.write("setting", setting);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Successfully!'),
          backgroundColor: Colors.green[300]));
    }
  }

  void _smallBlindChanged(value) {
    if (value == "") {
      bigBlindController.text = "";
    } else {
      bigBlindController.text = (int.parse(value) * 2).toString();
    }
  }

  void _bigBlindChanged(value) {
    if (value == "") {
      smallBlindController.text = "";
    } else {
      smallBlindController.text = (int.parse(value) / 2).ceil().toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          floatingActionButton: IconButton(
            onPressed: () => _saveSetting(),
            icon: const Icon(Icons.save_as, size: 35),
            color: Colors.blue,
          ),
          appBar: AppBar(
              // leading: BackButton(
              //     color: Colors.white,
              //     onPressed: () => Navigator.of(context)
              //         .pushNamedAndRemoveUntil(Routes.HOME, (route) => false)),
              title: const Text('Setting for your poker tour')),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: const Text(
                            "Small blind",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: const Text(
                            "Big blind",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: smallBlindController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black38),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onChanged: (value) => _smallBlindChanged(value),
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Small blind is require";
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: bigBlindController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black38),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onChanged: (value) => _bigBlindChanged(value),
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Big blind is require";
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      "Player time",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: playerTimerController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "1",
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixText: "minutes",
                      suffixStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.black38),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Player time is require";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      "Blind time",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: blindTimerController,
                    decoration: InputDecoration(
                      hintText: "30",
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixText: "minutes",
                      suffixStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 2, color: Colors.black38),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Blind time is require";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
