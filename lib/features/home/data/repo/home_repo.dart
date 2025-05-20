import 'package:chat_app/core/constants/firebase_cons.dart';
import 'package:chat_app/core/enums/type_chat.dart';
import 'package:chat_app/features/home/data/models/message_model.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  ///get All Data Of Users
  Stream<QuerySnapshot> getAllUsers() {
    return _fireStore
        .collection(FireBaseConstants.users)
        .where(FireBaseConstants.id, isNotEqualTo: _auth.currentUser!.uid)
        .snapshots();
  }

  ///get Current User
  Future<UserModel> getCurrentUser() async {
    final user =
        await _fireStore
            .collection(FireBaseConstants.users)
            .doc(_auth.currentUser!.uid)
            .get();
    return UserModel.fromJson(user.data()!);
  }

  // get chat id
  String getChatId({required String userId, required String toldId}) {
    return (userId.compareTo(toldId) < 0
        ? "${userId}_$toldId"
        : "${toldId}_$userId");
  }

  // get all messages of current user with anohter chat
  Stream<QuerySnapshot> getAllMessages({required String toldId}) {
    return _fireStore
        .collection(
          '${FireBaseConstants.chats}/${getChatId(userId: _auth.currentUser!.uid, toldId: toldId)}/${FireBaseConstants.messages}',
        )
        .orderBy(FireBaseConstants.sent)
        .snapshots();
  }

  ///send message to another user
  Future<void> sendMessage({
    required String toldId,
    required String message,
  }) async {
    final messageModel = _getSendMsg(toldId, message);

    await _fireStore
        .collection(
          '${FireBaseConstants.chats}/${getChatId(userId: _auth.currentUser!.uid, toldId: toldId)}/${FireBaseConstants.messages}',
        )
        .doc(messageModel.sent)
        .set(messageModel.toJson());
  }

  // get send message
  MessageModel _getSendMsg(String toldId, String message) {
    return MessageModel(
      senderId: _auth.currentUser!.uid,
      toldId: toldId,
      message: message,
      sent: DateTime.now().millisecondsSinceEpoch.toString(),
      read: '',
      type: TypeChat.text,
    );
  }

  ///update read msg
  Future<void> updateReadMsg({
    required String toldId,
    required String sendTime,
  }) async {
    await _fireStore
        .collection(
          '${FireBaseConstants.chats}/${getChatId(userId: _auth.currentUser!.uid, toldId: toldId)}/${FireBaseConstants.messages}',
        )
        .doc(sendTime)
        .update({
          FireBaseConstants.read:
              DateTime.now().millisecondsSinceEpoch.toString(),
        });
  }

  ///get last msg in each chat
  Stream<QuerySnapshot> getLastMsg({required String toldId}) {
    return _fireStore
        .collection(
          '${FireBaseConstants.chats}/${getChatId(userId: _auth.currentUser!.uid, toldId: toldId)}/${FireBaseConstants.messages}',
        )
        .orderBy(FireBaseConstants.sent, descending: true)
        .limit(1)
        .snapshots();
  }
}
