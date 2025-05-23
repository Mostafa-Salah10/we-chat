import 'package:chat_app/core/functions/handel_date.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/core/widgets/app_spaces.dart';
import 'package:chat_app/features/home/data/models/message_model.dart';
import 'package:chat_app/features/home/presentation/manager/home_service.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CustomBottomMsgBottomSheet extends StatelessWidget {
  const CustomBottomMsgBottomSheet({
    super.key,
    required this.messageModel,
    required this.isMe,
  });
  final MessageModel messageModel;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final home = context.read<HomeService>();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockWidth * 4,
        vertical: SizeConfig.blockHeight * 2,
      ),
      width: double.infinity,
      height:
          isMe
              ? SizeConfig.screenHeight * 0.40
              : SizeConfig.screenHeight * 0.30,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Align(child: _getSmallDivider(65)),
          VerticalSpace(height: 2),
          InkWell(
            onTap: () {
              copyText(messageModel.message);
              Navigator.pop(context);
            },

            child: _getOptionTile(context, AppStrings.copy, Icons.copy),
          ),
          !isMe
              ? SizedBox()
              : Column(
                children: [
                  VerticalSpace(height: 1),

                  Divider(),
                  VerticalSpace(height: 1),

                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomEditDialog(messageModel: messageModel);
                        },
                      );
                    },
                    child: _getOptionTile(context, AppStrings.edit, Icons.edit),
                  ),
                  VerticalSpace(height: 2),

                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      home.deleteMsg(
                        toldId: messageModel.toldId,
                        sendTime: messageModel.sent,
                      );
                    },
                    child: _getOptionTile(
                      context,
                      AppStrings.delete,
                      Icons.delete_forever_outlined,
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
          VerticalSpace(height: 1),
          Divider(),
          VerticalSpace(height: 1),
          _getOptionTile(
            context,
            AppStrings.seenAt + handleDate(context, messageModel.sent),
            Icons.visibility,
          ),
          VerticalSpace(height: 2),
          _getOptionTile(
            context,
            messageModel.read.isEmpty?'':
            AppStrings.readAt + handleDate(context, messageModel.read),
            Icons.visibility,
            color: AppColors.green,
          ),
        ],
      ),
    );
  }

  Row _getOptionTile(
    BuildContext context,
    String text,
    IconData icon, {
    Color color = AppColors.blueAccent,
  }) {
    return Row(
      children: [
        Icon(icon, color: color),
        HorizontilSpace(width: 2),
        Text(
          text.isEmpty ? AppStrings.notSeen : text,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Container _getSmallDivider(double width) {
    return Container(
      width: width,
      height: 3,
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
