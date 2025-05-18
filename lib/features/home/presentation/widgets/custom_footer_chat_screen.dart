import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/features/home/presentation/manager/home_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomFooterChatScreen extends StatelessWidget {
  const CustomFooterChatScreen({super.key, required this.toldId});
  final String toldId;

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
                  Expanded(child: _getTextField(context)),
                  _getIcon(Icons.image, () {}),
                  _getIcon(Icons.camera_alt_rounded, () {}),
                ],
              ),
            ),
          ),

          _getSendButton(context),
        ],
      ),
    );
  }

  MaterialButton _getSendButton(BuildContext context) {
    final home = context.read<HomeService>();
    return MaterialButton(
      minWidth: 50,
      height: 50,
      padding: const EdgeInsets.only(left: 5),
      onPressed: () async {
        String msg = home.messageController.text;
        home.messageController.clear();
        msg.isEmpty
            ? null
            : await home.sendMessage(message: msg, toldId: toldId);
      },
      shape: CircleBorder(),
      color: AppColors.green,
      child: const Icon(Icons.send, color: AppColors.white, size: 30),
    );
  }

  IconButton _getIcon(IconData icon, void Function()? onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: AppColors.ligthGreen),
    );
  }

  TextField _getTextField(BuildContext context) {
    return TextField(
      controller: context.read<HomeService>().messageController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      cursorColor: AppColors.black,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: AppStrings.typeSomething,
        hintStyle: TextStyle(color: AppColors.black),
      ),
    );
  }
}
