import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData theme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      centerTitle: true,
      shadowColor: AppColors.black,
      elevation: 1,
      iconTheme: const IconThemeData(color: AppColors.black),
    ),
    scaffoldBackgroundColor: AppColors.white,
    textTheme: TextTheme(
      headlineMedium: AppTextStyles.tileStyle,
      headlineSmall: AppTextStyles.butttonStyle,
      bodyMedium: AppTextStyles.cardStyle,
      bodySmall: AppTextStyles.subTitle,
    ),

    iconTheme: const IconThemeData(color: AppColors.white),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.green,
      foregroundColor: AppColors.white,
      shape: CircleBorder(),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: AppColors.lightGrey, fontSize: 16),
      errorBorder: getOutlineTextFieldBorder(color: AppColors.red),
      focusedBorder: getOutlineTextFieldBorder(color: AppColors.lightGrey),
      enabledBorder: getOutlineTextFieldBorder(color: AppColors.lightGrey),
      focusedErrorBorder: getOutlineTextFieldBorder(color: AppColors.red),
    ),
  );

  static OutlineInputBorder getOutlineTextFieldBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 0.6),
    );
  }
}
