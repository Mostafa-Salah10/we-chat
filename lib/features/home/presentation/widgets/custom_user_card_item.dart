import 'dart:io';

import 'package:chat_app/core/functions/custom_navigator.dart';
import 'package:chat_app/core/functions/handel_date.dart';
import 'package:chat_app/core/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/widgets/cached_network_image_widget.dart';
import 'package:chat_app/features/home/data/models/message_model.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_image_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomUserCardItem extends StatelessWidget {
  const CustomUserCardItem({
    super.key,
    this.chachedImage,
    required this.userModel,
    this.lastMsg,
  });
  final File? chachedImage;
  final UserModel userModel;
  final MessageModel? lastMsg;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: ListTile(
        onTap: () {
          userModel.fileImage = chachedImage;
          customPush(context, route: AppRoutes.chatScreen, argument: userModel);
        },
        leading: InkWell(
          onTap: () {
            userModel.fileImage = chachedImage;
            showDialog(
              context: context,
              builder: (context) => CustomImageDialog(user: userModel),
            );
          },
          child: _getLeading(chachedImage),
        ),
        title: Text(
          maxLines: 1,
          userModel.name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: _getSubTileText(
          context,
          lastMsg == null ? userModel.about : lastMsg!.message,
          lastMsg,
        ),
        trailing: _getTrailingText(context, lastMsg),
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

  Widget _getSubTileText(
    BuildContext context,
    String text,
    MessageModel? lastMsg,
  ) {
    return Row(
      children: [
        lastMsg == null || lastMsg.senderId == userModel.id
            ? SizedBox()
            : lastMsg.read.isNotEmpty
            ? const Icon(Icons.done_all_outlined, color: AppColors.blueAccent)
            : const Icon(Icons.done_all_outlined, color: AppColors.lightGrey),
        SizedBox(width: 5),
        Text(
          maxLines: 1,
          text,
          style:
              lastMsg != null &&
                      lastMsg.senderId == userModel.id &&
                      lastMsg.read.isEmpty
                  ? Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )
                  : Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _getTrailingText(BuildContext context, MessageModel? lastMsg) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          maxLines: 1,
          lastMsg == null
              ? ""
              : formatChatTimeFromMillisString(userModel.lastActive),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        lastMsg == null || lastMsg.senderId != userModel.id
            ? const SizedBox()
            : lastMsg.read.isEmpty
            ? CircleAvatar(radius: 8, backgroundColor: AppColors.green)
            : SizedBox(),
      ],
    );
  }
}
