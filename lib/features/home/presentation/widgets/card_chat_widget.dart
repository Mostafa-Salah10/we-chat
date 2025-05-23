import 'package:chat_app/core/functions/handel_date.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/home/data/models/message_model.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_bottom_msg_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CardChatWidget extends StatelessWidget {
  const CardChatWidget({
    super.key,
    required this.message,
    required this.toldId,
  });
  final MessageModel message;
  final String toldId;

  @override
  Widget build(BuildContext context) {
    bool isMe = message.senderId != toldId;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: InkWell(
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder:
                (context) => CustomBottomMsgBottomSheet(
                  messageModel: message,
                  isMe: isMe,
                ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: isMe ? _getLocalBoxDecration() : _getRemoteBoxDecration(),
          child: _getMsgText(isMe, message, context),
        ),
      ),
    );
  }

  Row _getMsgText(bool isMe, MessageModel message, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            message.message,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.visible,
          ),
        ),
        const SizedBox(width: 14),
        Text(
          handleDate(context, message.sent),
          style: TextStyle(color: AppColors.black, fontSize: 13),
        ),
        const SizedBox(width: 14),
        isMe
            ? message.read.isNotEmpty
                ? const Icon(
                  Icons.done_all_outlined,
                  color: AppColors.blueAccent,
                )
                : const Icon(
                  Icons.done_all_outlined,
                  color: AppColors.lightGrey,
                )
            : SizedBox(),
      ],
    );
  }

  BoxDecoration _getRemoteBoxDecration() {
    return BoxDecoration(
      color: const Color.fromARGB(255, 243, 235, 235),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    );
  }

  BoxDecoration _getLocalBoxDecration() {
    return BoxDecoration(
      color: AppColors.senderColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
        bottomLeft: Radius.circular(30),
      ),
    );
  }
}
