import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:mission_diary/global/color.dart';

class MissionDiaryTheme {
  static final light = FlexThemeData.light(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ThemeColors.slateBlue,
      onPrimary: Colors.white,
      secondary: ThemeColors.skyBlue,
      onSecondary: Colors.black,
      error: ThemeColors.lightCoral,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      surfaceTint: Colors.transparent,
    ),
  );
  static final dark = FlexThemeData.dark(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: ThemeColors.slateBlue,
      onPrimary: Colors.white,
      secondary: ThemeColors.skyBlue,
      onSecondary: Colors.black,
      error: ThemeColors.lightCoral,
      onError: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
      surfaceTint: Colors.transparent,
    ),
  );
}
