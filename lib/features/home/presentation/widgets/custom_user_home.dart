import 'dart:io';
import 'package:chat_app/features/home/data/models/message_model.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:chat_app/features/home/presentation/manager/home_service.dart';
import 'package:chat_app/features/home/presentation/widgets/custom_user_card_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomUserItem extends StatelessWidget {
  const CustomUserItem({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final home = context.read<HomeService>();
    final File? chachedImage = home.userImageFile;
    return StreamBuilder(
      stream: home.getLastMsg(toldId: userModel.id),
      builder: (context, snapshot) {
        return _handleStream(snapshot, context, userModel, chachedImage);
      },
    );
  }

  Widget _handleStream(
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
    BuildContext context,
    UserModel userModel,
    File? chachedImage,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: SizedBox());
    } else {
      final MessageModel? lastMsg;
      final queryDoc = snapshot.data!.docs;
      if (queryDoc.isEmpty) {
        lastMsg = null;
      } else {
        lastMsg = MessageModel.fromJson(
          queryDoc.first.data() as Map<String, dynamic>,
        );
      }
      return CustomUserCardItem(
        userModel: userModel,
        chachedImage: chachedImage,
        lastMsg: lastMsg,
      );
    }
  }
}
