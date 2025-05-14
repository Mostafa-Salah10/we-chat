import 'package:chat_app/core/constants/firebase_cons.dart'
    show FireBaseConstants;

class UserModel {
  final String image;
  final String about;
  final String name;
  final String createdAt;
  final bool isOnline;
  final String id;
  final String lastActive;
  final String pushToken;
  final String email;

  UserModel({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.isOnline,
    required this.id,
    required this.lastActive,
    required this.pushToken,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      image: json[FireBaseConstants.image],
      about: json[FireBaseConstants.about],
      name: json[FireBaseConstants.name],
      createdAt: json[FireBaseConstants.createdAt],
      isOnline: json[FireBaseConstants.isOnline],
      id: json[FireBaseConstants.id],
      lastActive: json[FireBaseConstants.lastActive],
      pushToken: json[FireBaseConstants.pushToken],
      email: json[FireBaseConstants.email],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FireBaseConstants.image: image,
      FireBaseConstants.about: about,
      FireBaseConstants.name: name,
      FireBaseConstants.createdAt: createdAt,
      FireBaseConstants.isOnline: isOnline,
      FireBaseConstants.id: id,
      FireBaseConstants.lastActive: lastActive,
      FireBaseConstants.pushToken: pushToken,
      FireBaseConstants.email: email,
    };
  }

  UserModel copyWith({
    String? image,
    String? about,
    String? name,
    String? createdAt,
    bool? isOnline,
    String? id,
    String? lastActive,
    String? pushToken,
    String? email,
  }) {
    return UserModel(
      image: image ?? this.image,
      about: about ?? this.about,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      isOnline: isOnline ?? this.isOnline,
      id: id ?? this.id,
      lastActive: lastActive ?? this.lastActive,
      pushToken: pushToken ?? this.pushToken,
      email: email ?? this.email,
    );
  }
}
