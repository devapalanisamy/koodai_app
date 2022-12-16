import 'package:flutter/material.dart';

class CustomColorScheme {
  static ColorScheme getColorScheme() {
    return ColorScheme(
        primary: Color(0xFFF2A900),
        primaryVariant: Color(0xFFFFC219),
        secondary: Color(0xFF173F35),
        secondaryVariant: Color(0xFF557D73),
        background: Color(0xFFF8F8F8),
        surface: Color(0xFFFFFFFF),
        error: Color(0xFFB00020),
        onPrimary: Color(0xFF2E2A24),
        onSecondary: Color(0xFFFFFFFF),
        onBackground: Color(0xFF181100),
        onSurface: Color(0xFF2E2A24),
        onError: Color(0xFFFFFFFF),
        brightness: Brightness.light);
  }
}
