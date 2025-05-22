import 'dart:io';
import 'package:chat_app/core/functions/custom_navigator.dart';
import 'package:chat_app/core/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/core/widgets/app_spaces.dart';
import 'package:chat_app/core/widgets/cached_network_image_widget.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomImageDialog extends StatelessWidget {
  const CustomImageDialog({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: SizeConfig.blockWidth * 40,
        height: SizeConfig.blockHeight * 35,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              _getRowInfo(context),
              VerticalSpace(height: 3),
              Expanded(child: _getImageProfile(user.fileImage)),
            ],
          ),
        ),
      ),
    );
  }

  Row _getRowInfo(BuildContext context) {
    return Row(
      children: [
        Text(user.name, style: Theme.of(context).textTheme.bodyMedium),
        Spacer(),
        IconButton(
          onPressed: () {
            customPush(context, route: AppRoutes.detailsScreen, argument: user);
          },
          icon: Icon(Icons.info_outline, color: AppColors.ligthGreen),
        ),
      ],
    );
  }

  ClipRRect _getImageProfile(File? chachedImage) {
    return chachedImage != null
        ? ClipRRect(
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 100),
          child: Image.file(
            chachedImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        )
        : ClipRRect(
          borderRadius: BorderRadius.circular(SizeConfig.blockHeight * 100),
          child: CustomCachedNetworkImage(
            imageUrl: user.image,
            errWidget: CircleAvatar(
              radius: SizeConfig.blockWidth * 10,
              backgroundColor: AppColors.green,
              child: const Icon(CupertinoIcons.person, color: AppColors.white),
            ),
          ),
        );
  }
}
