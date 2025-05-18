import 'dart:io';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/widgets/cached_network_image_widget.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_chat_body_widget.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_footer_chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: _appBarLeading(context),
      ),

      body: Column(
        children: [
          Expanded(child: CustomChatBodyWidget(toldId: userModel.id)),
          CustomFooterChatScreen(toldId: userModel.id),
        ],
      ),
    );
  }

  Row _appBarLeading(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        _getImageProfile(userModel.fileImage),
        const SizedBox(width: 10),
        _getTextColumn(context),
      ],
    );
  }

  Column _getTextColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(userModel.name, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          "${AppStrings.lastSeen}12:00 PM",

          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  ClipRRect _getImageProfile(File? chachedImage) {
    return chachedImage != null
        ? ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.file(
            chachedImage,
            fit: BoxFit.fill,
            width: 40,
            height: 40,
          ),
        )
        : ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CustomCachedNetworkImage(
            imageUrl: userModel.image,
            errWidget: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.green,
              child: const Icon(CupertinoIcons.person, color: AppColors.white),
            ),
          ),
        );
  }
}
