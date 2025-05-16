import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/assets.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/core/widgets/app_spaces.dart';
import 'package:flutter/material.dart';

class CustomChooseImgeWidget extends StatelessWidget {
  const CustomChooseImgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeConfig.blockHeight * 28,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),

      child: Column(
        children: [
          VerticalSpace(height: 2),
          Text(
            AppStrings.pickImage,
            style: TextStyle(color: AppColors.black, fontSize: 20),
          ),
          VerticalSpace(height: 3),
          _getImageRow(),
        ],
      ),
    );
  }

  Row _getImageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getImageSource(Assets.imagesGallery, () {}),
        HorizontilSpace(width: 10),
        _getImageSource(Assets.imagesCircle, () {}),
      ],
    );
  }

  MaterialButton _getImageSource(String image, void Function()? onPressed) {
    return MaterialButton(
      padding: const EdgeInsets.all(15),
      elevation: 10,
      shape: CircleBorder(),
      color: AppColors.white,
      onPressed: onPressed,
      child: Image.asset(image, fit: BoxFit.fill, width: 70, height: 70),
    );
  }
}
