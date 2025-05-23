import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/widgets/app_spaces.dart';
import 'package:chat_app/features/home/data/models/message_model.dart';
import 'package:chat_app/features/home/presentation/manager/home_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomEditDialog extends StatelessWidget {
  const CustomEditDialog({super.key, required this.messageModel});
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    final home = context.read<HomeService>();
    String newMsg = '';
    return AlertDialog(
      title: _getRow(context),
      content: TextFormField(
        maxLines: null,
        onChanged: (value) => newMsg = value,
        initialValue: messageModel.message,
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
      actions: _getActions(context, home, newMsg),
    );
  }

  List<Widget> _getActions(BuildContext context, HomeService home, String newMsg) {
    return [
      InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Text(
          AppStrings.cancel,
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(color: AppColors.blueAccent),
        ),
      ),
      SizedBox(width: 20),
      InkWell(
        onTap: () async {
          Navigator.pop(context);
          await home.updateMsg(
            toldId: messageModel.toldId,
            sendTime: messageModel.sent,
            message: newMsg,
          );
        },
        child: Text(
          AppStrings.update,
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(color: AppColors.blueAccent),
        ),
      ),
    ];
  }

  Row _getRow(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.chat, color: AppColors.blueAccent),
        HorizontilSpace(width: 5),
        Text(
          AppStrings.edit,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
