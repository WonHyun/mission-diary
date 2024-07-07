import 'package:flutter/material.dart';
import 'package:mission_diary/global/color.dart';

class DiaryTheme {
  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ThemeColors.primaryColor,
      onPrimary: Colors.white,
      secondary: Color(0xFF2C5EAD),
      onSecondary: Colors.black,
      error: Color(0xffb00020),
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      surfaceTint: Colors.transparent,
    ),
  );
  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: ThemeColors.primaryColor,
      onPrimary: Colors.white,
      secondary: Color(0xFF2C5EAD),
      onSecondary: Colors.black,
      error: Color(0xffb00020),
      onError: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
      surfaceTint: Colors.transparent,
    ),
  );
}
