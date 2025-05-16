import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/core/widgets/cached_network_image_widget.dart';
import 'package:chat_app/features/profile/presentation/widgets/custom_choose_image.dart';
import 'package:flutter/material.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [_getProfileImage(), _getEditIcon(context)],
    );
  }

  ClipRRect _getProfileImage() {
    return ClipRRect(
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
            builder: (context) => CustomChooseImgeWidget(),
          );
        },
        color: AppColors.green,
        shape: CircleBorder(),
        child: const Icon(Icons.edit, color: AppColors.white, size: 20),
      ),
    );
  }
}
