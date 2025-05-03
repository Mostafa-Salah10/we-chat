import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static TextStyle _textStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: 'Inter',
      color: color,
      overflow: TextOverflow.ellipsis,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle get tileStyle => _textStyle(
    fontSize: SizeConfig.textSize * 3,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );
}
