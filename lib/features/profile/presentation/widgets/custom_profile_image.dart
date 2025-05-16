import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/core/widgets/cached_network_image_widget.dart';
import 'package:chat_app/features/profile/presentation/manager/profile_service.dart';
import 'package:chat_app/features/profile/presentation/widgets/custom_choose_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({super.key, required this.image, required this.id});
  final String image;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Consumer<ProfileService>(
          builder: (context, value, child) => _getProfileImage(value),
        ),
        _getEditIcon(context),
      ],
    );
  }

  ClipRRect _getProfileImage(ProfileService value) {
    return value.userImageFile != null
        ? ClipRRect(
          borderRadius: BorderRadius.circular(SizeConfig.blockHeight * 7.5),
          child: Image.file(
            value.userImageFile!,
            width: SizeConfig.blockHeight * 15,
            height: SizeConfig.blockHeight * 15,
            fit: BoxFit.fill,
          ),
        )
        : ClipRRect(
          borderRadius: BorderRadius.circular(SizeConfig.blockHeight * 7.5),
          child: CustomCachedNetworkImage(
            width: SizeConfig.blockHeight * 15,
            height: SizeConfig.blockHeight * 15,
            fit: BoxFit.fill,
            imageUrl: image,
          ),
        );
  }

  Positioned _getEditIcon(context) {
    return Positioned(
      bottom: -15,
      right: -15,
      child: MaterialButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => CustomChooseImgeWidget(id: id),
          );
        },
        color: AppColors.green,
        shape: CircleBorder(),
        child: const Icon(Icons.edit, color: AppColors.white, size: 20),
      ),
    );
  }
}
