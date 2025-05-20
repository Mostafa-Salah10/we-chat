import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/features/home/data/models/message_model.dart';
import 'package:chat_app/features/home/presentation/manager/home_service.dart';
import 'package:chat_app/features/home/presentation/widgets/card_chat_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomChatBodyWidget extends StatelessWidget {
  const CustomChatBodyWidget({super.key, required this.toldId});
  final String toldId;

  @override
  Widget build(BuildContext context) {
    final home = context.read<HomeService>();
    return StreamBuilder<QuerySnapshot>(
      stream: home.getAllMessages(toldId: toldId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(color: AppColors.green),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            return _handelSMsgs(snapshot, context);
        }
      },
    );
  }

  Widget _handelSMsgs(
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
    BuildContext context,
  ) {
    final queryDoc = snapshot.data!.docs;
    if (queryDoc.isEmpty) {
      return Center(
        child: Text(AppStrings.sayHi, style: TextStyle(color: AppColors.black)),
      );
    } else {
      final List<MessageModel> messages =
          queryDoc
              .map(
                (message) => MessageModel.fromJson(
                  message.data() as Map<String, dynamic>,
                ),
              )
              .toList();
      return ListView.builder(
        // reverse: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: SizeConfig.blockHeight * 2),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final home = context.read<HomeService>();
          messages[index].read.isEmpty && messages[index].senderId == toldId
              ? home.updateReadMsg(
                toldId: toldId,
                sendTime: messages[index].sent,
              )
              : null;
          return CardChatWidget(toldId: toldId, message: messages[index]);
        },
      );
    }
  }
}
