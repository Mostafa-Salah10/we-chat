import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomFooterChatScreen extends StatelessWidget {
  const CustomFooterChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockWidth * 2.3),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  _getIcon(Icons.emoji_emotions, () {}),
                  Expanded(child: _getTextField()),
                  _getIcon(Icons.image, () {}),
                  _getIcon(Icons.camera_alt_rounded, () {}),
                ],
              ),
            ),
          ),

          _getSendButton(),
        ],
      ),
    );
  }

  MaterialButton _getSendButton() {
    return MaterialButton(
      minWidth: 50,
      height: 50,
      padding: const EdgeInsets.only(left: 5),
      onPressed: () {},
      shape: CircleBorder(),
      color: AppColors.green,
      child: const Icon(Icons.send, color: AppColors.white, size: 30),
    );
  }

  IconButton _getIcon(IconData icon, void Function()? onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: AppColors.blueAccent),
    );
  }

  TextField _getTextField() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      cursorColor: AppColors.blueAccent,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: AppStrings.typeSomething,
        hintStyle: const TextStyle(color: AppColors.blueAccent),
      ),
    );
  }
}
