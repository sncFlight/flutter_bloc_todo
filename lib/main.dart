import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:bloc_to_do/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences from storage
  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  
  // Set preferred device orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(Application(sharedPref: sharedPref));
}
