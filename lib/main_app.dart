import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission_diary/router.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: FlexThemeData.light(),
      darkTheme: FlexThemeData.dark(),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
