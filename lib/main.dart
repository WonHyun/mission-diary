import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/initalize_app.dart';

import 'main_app.dart';

void main() async {
  await InitalizeApp.initalize();
  runApp(
    DevicePreview(
      enabled: InitalizeApp.useDevicePreview,
      builder: (context) => const ProviderScope(
        child: MainApp(),
      ),
    ),
  );
}
