import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/core/widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getProfileImage(), _getEditIcon()]);
  }

  ClipRRect _getProfileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(SizeConfig.blockHeight * 10),
      child: CustomCachedNetworkImage(
        width: SizeConfig.blockHeight * 20,
        height: SizeConfig.blockHeight * 20,
        fit: BoxFit.fill,
        imageUrl: image,
      ),
    );
  }

  Positioned _getEditIcon() {
    return Positioned(
      bottom: 10,
      right: 0,
      child: CircleAvatar(
        backgroundColor: AppColors.green,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit, color: AppColors.white),
        ),
      ),
    );
  }
}
