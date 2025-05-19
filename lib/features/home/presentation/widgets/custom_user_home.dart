import 'dart:io';

import 'package:chat_app/core/functions/custom_navigator.dart';
import 'package:chat_app/core/functions/handel_date.dart';
import 'package:chat_app/core/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/widgets/cached_network_image_widget.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:chat_app/features/home/presentation/manager/home_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomUserItem extends StatelessWidget {
  const CustomUserItem({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final File? chachedImage = context.read<HomeService>().userImageFile;
    return Card(
      color: AppColors.white,
      child: ListTile(
        onTap: () {
          userModel.fileImage = chachedImage;
          customPush(context, route: AppRoutes.chatScreen, argument: userModel);
        },
        leading: _getLeading(chachedImage),
        title: Text(
          maxLines: 1,
          userModel.name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: _getText(context, userModel.about),
        trailing: _getText(context,handleDate(context, userModel.lastActive)),
      ),
    );
  }

  ClipRRect _getLeading(File? chachedImage) {
    return chachedImage != null
        ? ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.file(
            chachedImage,
            fit: BoxFit.fill,
            width: 60,
            height: 60,
          ),
        )
        : ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CustomCachedNetworkImage(
            imageUrl: userModel.image,
            errWidget: CircleAvatar(
              radius: 29,
              backgroundColor: AppColors.green,
              child: const Icon(CupertinoIcons.person, color: AppColors.white),
            ),
          ),
        );
  }

  Text _getText(BuildContext context, String text) {
    return Text(
      maxLines: 1,
      text,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
