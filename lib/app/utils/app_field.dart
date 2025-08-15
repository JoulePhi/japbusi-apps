import 'package:flutter/material.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';

class AppField {
  static InputDecoration primaryField(
    String label,
    String hint,
    IconData prefixIcon, {
    IconButton? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(prefixIcon),
      labelStyle: AppTextStyles.caption.copyWith(fontSize: 14),
      hintStyle: AppTextStyles.caption.copyWith(
        color: AppColors.textSecondary,
        fontSize: 14,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
