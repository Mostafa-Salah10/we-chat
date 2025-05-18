import 'package:chat_app/core/constants/firebase_cons.dart';
import 'package:chat_app/core/enums/type_chat.dart';

class MessageModel {
  final String senderId;
  final String toldId;
  final String message;
  final String sent;
  final String read;
  final TypeChat type;

  MessageModel({
    required this.senderId,
    required this.toldId,
    required this.message,
    required this.sent,
    required this.read,
    required this.type,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
    : senderId = json[FireBaseConstants.senderId],
      toldId = json[FireBaseConstants.toldId],
      message = json[FireBaseConstants.message],
      sent = json[FireBaseConstants.sent],
      read = json[FireBaseConstants.read],
      type = getTypeChat(json[FireBaseConstants.type]);

  Map<String, dynamic> toJson() {
    return {
      FireBaseConstants.senderId: senderId,
      FireBaseConstants.toldId: toldId,
      FireBaseConstants.message: message,
      FireBaseConstants.sent: sent,
      FireBaseConstants.read: read,
      FireBaseConstants.type: type.name,
    };
  }

  MessageModel copyWith({
    String? senderId,
    String? toldId,
    String? message,
    String? sent,
    String? read,
    TypeChat? type,
  }) {
    return MessageModel(
      senderId: senderId ?? this.senderId,
      toldId: toldId ?? this.toldId,
      message: message ?? this.message,
      sent: sent ?? this.sent,
      read: read ?? this.read,
      type: type ?? this.type,
    );
  }
}
