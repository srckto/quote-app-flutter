import 'package:flutter/material.dart';
import 'package:quote/core/utils/app_colors.dart';
import 'package:quote/core/utils/app_strings.dart';

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: AppColors.primary,
    hintColor: AppColors.hint,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    fontFamily: AppStrings.fontFamily,
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          color: AppColors.white,
        ),
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      headline2: TextStyle(
        fontSize: 16,
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),
      headline3: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
