import 'package:flutter/material.dart';

class AppColors {
  static final int _primaryValue = Colors.black.value;
  static final MaterialColor primary = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: const Color(0xFF000000),
      100: const Color(0xFF000000),
      200: const Color(0xFF000000),
      300: const Color(0xFF000000),
      400: const Color(0xFF000000),
      500: Color(_primaryValue),
      600: const Color(0xFF000000),
      700: const Color(0xFF000000),
      800: const Color(0xFF000000),
      900: const Color(0xFF000000),
    },
  );
  
  static const Color hint = Colors.grey;
  static const Color white = Colors.white;
}
