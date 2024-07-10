import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:mission_diary/global/color.dart';

class MissionDiaryTheme {
  static final light = FlexThemeData.light(
    useMaterial3: true,
    primary: ThemeColors.slateBlue,
    secondary: ThemeColors.skyBlue,
    error: ThemeColors.lightCoral,
    surfaceTint: Colors.transparent,
  );
  static final dark = FlexThemeData.dark(
    useMaterial3: true,
    primary: ThemeColors.slateBlue,
    secondary: ThemeColors.skyBlue,
    error: ThemeColors.lightCoral,
    surfaceTint: Colors.transparent,
  );
}
