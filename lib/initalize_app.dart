import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mission_diary/firebase_options.dart';
import 'package:mission_diary/global/enum.dart';
// import 'package:flutter/foundation.dart';

class InitalizeApp {
  //static const bool useDevicePreview = !kReleaseMode;
  static const bool useDevicePreview = false;

  static Future<void> initalize() async {
    WidgetsFlutterBinding.ensureInitialized();
    GoRouter.optionURLReflectsImperativeAPIs = true;

    await initHiveBoxes();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> initHiveBoxes() async {
    await Hive.initFlutter();
    if (!Hive.isBoxOpen(BoxName.settings.name)) {
      await Hive.openBox(BoxName.settings.name);
    }
  }
}
