import 'package:countdown_poker/screens/home_screen.dart';
import 'package:countdown_poker/screens/setting_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const HOME = "/";
  static const SETTING = "/setting";

  static final Map<String, Widget Function(BuildContext)> routes = {
    HOME: (context) => const HomeScreen(),
    SETTING: (context) => const SettingScreen(),
  };
}
