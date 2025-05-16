import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/core/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [_getProfileImage(), _getEditIcon()],
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

  Positioned _getEditIcon() {
    return Positioned(
      bottom: -15,
      right: -15,
      child: MaterialButton(
        onPressed: () {},
        color: AppColors.green,
        shape: CircleBorder(),
        child: const Icon(Icons.edit, color: AppColors.white, size: 20),
      ),
    );
  }
}
