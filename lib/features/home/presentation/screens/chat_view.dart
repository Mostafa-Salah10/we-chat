import 'dart:io';
import 'package:chat_app/core/functions/custom_navigator.dart';
import 'package:chat_app/core/functions/handel_date.dart';
import 'package:chat_app/core/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/widgets/cached_network_image_widget.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:chat_app/features/home/presentation/manager/home_service.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_chat_body_widget.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_emoji_widget.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_footer_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: InkWell(
          onTap:
              () => customPush(
                context,
                route: AppRoutes.detailsScreen,
                argument: userModel,
              ),
          child: _getStream(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => FocusScope.of(context).unfocus(),
              child: CustomChatBodyWidget(toldId: userModel.id),
            ),
          ),
          CustomFooterChatScreen(toldId: userModel.id),
          Consumer<HomeService>(
            builder:
                (_, value, _) =>
                    value.showEmoji ? CustomEmojiWidget() : const SizedBox(),
          ),
        ],
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> _getStream(BuildContext context) {
    return StreamBuilder(
      stream: context.read<HomeService>().getUserState(toldId: userModel.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox();
        } else {
          final queryDocs = snapshot.data?.docs.first;
          final UserModel user = UserModel.fromJson(
            queryDocs!.data() as Map<String, dynamic>,
          );
          return _appBarLeading(context, user);
        }
      },
    );
  }

  Row _appBarLeading(BuildContext context, UserModel user) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        _getImageProfile(userModel.fileImage, user),
        const SizedBox(width: 10),
        _getTextColumn(context, user),
      ],
    );
  }

  Column _getTextColumn(BuildContext context, UserModel userModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(userModel.name, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          userModel.isOnline
              ? AppStrings.online
              : "${AppStrings.lastSeen} ${formatChatTimeFromMillisString(userModel.lastActive)}",

          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  ClipRRect _getImageProfile(File? chachedImage, UserModel user) {
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
