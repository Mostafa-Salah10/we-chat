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
}
