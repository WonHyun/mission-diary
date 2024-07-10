import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/global/theme.dart';
import 'package:mission_diary/router.dart';
import 'package:mission_diary/widgets/setting/view_model/setting_view_model.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      themeMode: ref.watch(settingProvider).themeMode,
      theme: MissionDiaryTheme.light,
      darkTheme: MissionDiaryTheme.dark,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
