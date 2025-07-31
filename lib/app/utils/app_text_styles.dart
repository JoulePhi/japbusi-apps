// lib/app/utils/app_text_styles.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle headline1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle headline2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle headline3 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle body1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.0,
    color: AppColors.textPrimary,
  );

  static TextStyle body2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.0,
    color: AppColors.textSecondary,
  );

  static TextStyle button = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle caption = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12.0,
    color: AppColors.textSecondary,
  );
  static TextStyle primary = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.0,
    color: AppColors.primaryColor,
  );
  static TextStyle secondary = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.0,
    color: AppColors.textSecondary,
  );
  static TextStyle error = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.0,
    color: AppColors.errorColor,
  );
  static TextStyle success = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.0,
    color: AppColors.successColor,
  );
  static TextStyle white = TextStyle(
    fontFamily: 'Poppins',
    color: Colors.white,
  );
}
