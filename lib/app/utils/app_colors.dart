// lib/app/utils/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF008FCE);
  static const Color accentColor = Color(0xFFFF4081);
  static const Color backgroundColor = Colors.white;
  static const Color cardColor = Colors.white;
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textPurple = Color(0xFF2D2A70);
  static const Color textPurpleAccent = Color(0xFFDFF5FF);
  static const Color dividerColor = Color(0xFFBDBDBD);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF00935E);
  static const Color orangeColor = Color(0xFFFF9202);
  static const Color yellowColor = Color(0xFFfbbc06);
  static const Color successAccentColor = Color(0xFF6CC72C);
  static const Color background = Colors.white;
  static const Color teal = Color(0xff66d1d1);

  static const statusColors = {
    0: orangeColor, // Amber
    1: successColor, // Blue
    2: errorColor, // Green
    3: textSecondary, // Red
    -1: Color(0xFF9E9E9E), // Grey
  };
  static const stepColors = {
    0: yellowColor, // Amber
    1: teal, // Blue
    2: orangeColor, // Green
    3: orangeColor, // Red
    4: orangeColor, // Grey
    5: orangeColor, // Grey
  };
  static const replyColors = {
    0: yellowColor, // Amber
    1: teal, // Blue
    2: orangeColor, // Green
    3: orangeColor, // Red
  };
}
