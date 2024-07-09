import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/global/theme.dart';
import 'package:mission_diary/router.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      theme: MissionDiaryTheme.light,
      darkTheme: MissionDiaryTheme.dark,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
