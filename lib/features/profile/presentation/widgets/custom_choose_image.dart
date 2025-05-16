import 'dart:io';

import 'package:chat_app/core/repo/global_repo.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/assets.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/core/widgets/app_spaces.dart';
import 'package:chat_app/features/profile/presentation/manager/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomChooseImgeWidget extends StatelessWidget {
  const CustomChooseImgeWidget({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileService>();
    return Container(
      width: double.infinity,
      height: SizeConfig.blockHeight * 26,
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
          _getImageRow(context, profile),
        ],
      ),
    );
  }

  Row _getImageRow(context, ProfileService profile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getImageSource(Assets.imagesGallery, () async {
          final File? file = await GlobalRepo.getImageFromMobile(
            fromGallary: true,
          );
          if (file != null) {
            await profile.updateProfileImage(imageFile: file, userId: id);
          }
          Navigator.pop(context);
        }),
        HorizontilSpace(width: 10),
        _getImageSource(Assets.imagesCircle, () async {
          final File? file = await GlobalRepo.getImageFromMobile(
            fromGallary: false,
          );
          if (file != null) {
            await profile.updateProfileImage(imageFile: file, userId: id);
          }
          Navigator.pop(context);
        }),
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
