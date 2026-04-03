import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF6A13CC);
  static const Color primaryDark = Color(0xFF3B0F6D);
  static const Color primaryLight = Color(0xFFF7EFFF);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color lightGrey1 = Color(0xFFE2E6EF);
  static const Color lightGrey2 = Color(0xFFEDEDED);
  static const Color lightGrey3 = Color(0xFF546071);
  static const Color white = Colors.white;
  static const Color textBlack = Color(0xFF1C1C1C);
  static const Color grey = Color(0xFF777777);
  static const Color darkGrey = Color(0xFF383838);
  static const Color purpleColor = Color(0xFF7E27E0);
  static const Color darkPurple = Color(0xFF633795);
  static const Color red = Color(0xFFC50000);
  static const Color yellow = Color(0xFFC58F00);
  static const Color lightYellow = Color(0xFFF8F1E0);
  static const Color lightBlue = Color(0xFF608AE9);
  static const Color blue = Color(0xFF0043DB);
  static const Color green = Color(0xFF2FC800);
  static const Color darkGreen = Color(0xFF008000);
  static const Color lightGreen = Color(0xFFE5F2E5);
  static const Color fillColor = Color(0xFFF6F7F9);

  static LinearGradient primaryGradient = const LinearGradient(
    colors: [primaryDark, primary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient blackGradient = const LinearGradient(
    colors: [AppColors.textBlack, Color(0xFF4C4C4C)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static LinearGradient greenGradient = const LinearGradient(
    colors: [Color(0xFF186D0F), Color(0xFF13CC2B)],
  );

  static LinearGradient greenGradient1 = const LinearGradient(
    colors: [Color(0xFF069C17), Color(0xFF13CC2B)],
  );
}
