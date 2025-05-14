import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomUserItem extends StatelessWidget {
  const CustomUserItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: ListTile(
        onTap: () {},
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.green,
          child: const Icon(CupertinoIcons.person, color: AppColors.white),
        ),
        title: Text(
          maxLines: 1,
          "Mostafa Salah",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: _getText(context, "Hello how are you?"),
        trailing: _getText(context, "10:00 PM"),
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
