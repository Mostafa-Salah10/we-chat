import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/widgets/cached_network_image_widget.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomUserItem extends StatelessWidget {
  const CustomUserItem({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: ListTile(
        onTap: () {},
        leading: _getLeading(),
        title: Text(
          maxLines: 1,
          userModel.name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: _getText(context, userModel.about),
        trailing: _getText(context, "12:00 PM"),
      ),
    );
  }

  ClipRRect _getLeading() {
    return ClipRRect(
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
