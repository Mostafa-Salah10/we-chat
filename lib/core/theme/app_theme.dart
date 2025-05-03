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
    textTheme: TextTheme(headlineMedium: AppTextStyles.tileStyle),
  );
}
