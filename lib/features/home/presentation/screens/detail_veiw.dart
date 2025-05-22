import 'dart:io';
import 'package:chat_app/core/functions/handel_date.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/core/widgets/app_spaces.dart';
import 'package:chat_app/core/widgets/cached_network_image_widget.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.name,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight * 5),
        child: Column(
          children: [
            _getImageProfile(user.fileImage),
            VerticalSpace(height: 4),
            Center(
              child: Text(
                user.email,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            VerticalSpace(height: 2),
            _getTextRich(AppStrings.about, user.about, context),
            Spacer(),
            _getTextRich(
              AppStrings.join,
              formatChatTimeFromMillisString(user.createdAt),
              context,
            ),
          ],
        ),
      ),
    );
  }

  ClipRRect _getImageProfile(File? chachedImage) {
    return chachedImage != null
        ? ClipRRect(
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 50),
          child: Image.file(
            chachedImage,
            fit: BoxFit.fill,
            width: SizeConfig.blockWidth * 50,
            height: SizeConfig.blockWidth * 50,
          ),
        )
        : ClipRRect(
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 50),
          child: CustomCachedNetworkImage(
            imageUrl: user.image,
            errWidget: CircleAvatar(
              radius: SizeConfig.blockWidth * 25,
              backgroundColor: AppColors.green,
              child: const Icon(CupertinoIcons.person, color: AppColors.white),
            ),
          ),
        );
  }

  Widget _getTextRich(String word, String text, BuildContext context) {
    return Text.rich(
      style: Theme.of(context).textTheme.bodySmall,
      TextSpan(
        children: [
          TextSpan(
            text: '$word : ',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: text),
        ],
      ),
    );
  }
}
