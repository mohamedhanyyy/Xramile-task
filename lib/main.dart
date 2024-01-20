import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xramile/services/shared_preferences/preferences_helper.dart';
import 'package:xramile/shared/functions/restart_app.dart';

import 'my_app.dart';

Future<void> main() async {
  /// To ensure asynchronous function has done
  WidgetsFlutterBinding.ensureInitialized();

  /// binding firebase project to flutter project

  await Firebase.initializeApp();

  /// initializing single instance from shared preferences

  PreferencesHelper.init();


  /// restart widget tree to lose all states when restarting application in case of logout

  runApp(const RestartWidget(child: MyApp()));
}
