import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/assets.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomSignInWithGoogleButton extends StatelessWidget {
  const CustomSignInWithGoogleButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: _getButtonStyle(),
      label: Text(
        AppStrings.signInWithGoogle,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      icon: _getGoogleImage(),
    );
  }

  Image _getGoogleImage() {
    return Image.asset(
      Assets.imagesGoogle,
      width: SizeConfig.blockHeight * 4,
      height: SizeConfig.blockHeight * 4,
    );
  }

  ButtonStyle _getButtonStyle() {
    return ElevatedButton.styleFrom(
      minimumSize: Size(SizeConfig.blockWidth * 80, SizeConfig.blockHeight * 7),
      backgroundColor: AppColors.green,
      elevation: 1,
      shadowColor: AppColors.green,
      shape: StadiumBorder(),
    );
  }
}
