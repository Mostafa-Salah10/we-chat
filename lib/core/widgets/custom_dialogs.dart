import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

abstract class CustomDialogs {
  static void showSnackBar({
    required BuildContext context,
    required String msg,
    Color? color,
  }) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: SizeConfig.blockWidth * 80,
      padding: const EdgeInsets.all(10),
      content: Text(
        msg,
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
      ),
      backgroundColor: color ?? AppColors.green,
      behavior: SnackBarBehavior.floating,
      shape: const StadiumBorder(),
    ),
  );

  static void showCircleProgressIndicatorDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => Center(
            child: const CircularProgressIndicator(color: AppColors.green),
          ),
    );
  }
}
