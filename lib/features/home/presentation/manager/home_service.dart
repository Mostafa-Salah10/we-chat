import 'dart:io';

import 'package:chat_app/core/database/cache/sharedpreferences_helper.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:chat_app/features/home/data/repo/home_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeService with ChangeNotifier {
  final HomeRepo homeRepo;
  late UserModel user;
  List<UserModel> users = [];
  List<UserModel> filterList = [];
  bool isSearch = false;
  bool showEmoji = false;
  File? userImageFile;
  final TextEditingController messageController = TextEditingController();

  HomeService({required this.homeRepo});

  ///get All Data Of Users
  Stream<QuerySnapshot> getAllUsers() {
    getCurrentUser();
    return homeRepo.getAllUsers();
  }

  ///get Current User
  Future<void> getCurrentUser() async {
    user = await homeRepo.getCurrentUser();
  }

  //update search flag
  void update(bool value) {
    isSearch = value;
    notifyListeners();
  }

  //update emoji flag
  void updateEmoji() {
    showEmoji = !showEmoji;
    notifyListeners();
  }

  // Search in  users chats
  void search(String query) {
    filterList.clear();

    filterList =
        query.isEmpty
            ? []
            : users
                .where(
                  (element) =>
                      element.name.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
    notifyListeners();
  }

  //load profile picture from db
  void loadImageFromCache({required String userId}) {
    final path = SharedPreferencesHelper.get(key: userId);
    if (path != null) {
      userImageFile = File(path);
    } else {
      userImageFile = null;
    }
  }

  ///send message to another user
  Future<void> sendMessage({
    required String toldId,
    required String message,
  }) async {
    await homeRepo.sendMessage(toldId: toldId, message: message);
  }

  ///get All Messages
  Stream<QuerySnapshot> getAllMessages({required String toldId}) {
    return homeRepo.getAllMessages(toldId: toldId);
  }

  ///update read msg
  Future<void> updateReadMsg({
    required String toldId,
    required String sendTime,
  }) async {
    await homeRepo.updateReadMsg(toldId: toldId, sendTime: sendTime);
  }

  ///get last msg in each chat
  Stream<QuerySnapshot> getLastMsg({required String toldId}) {
    return homeRepo.getLastMsg(toldId: toldId);
  }

  ///upadte user state
  Future<void> updateUserState({required bool isOnline}) async {
    await homeRepo.updateUserState(isOnline: isOnline);
  }

  ///listen to state of told user
  Stream<QuerySnapshot> getUserState({required String toldId}) {
    return homeRepo.getUserState(toldId: toldId);
  }

  ///delete msg
  Future<void> deleteMsg({
    required String toldId,
    required String sendTime,
  }) async {
    await homeRepo.deleteMsg(toldId: toldId, sendTime: sendTime);
  }

 //update msg
  Future<void> updateMsg({
    required String toldId,
    required String sendTime,
    required String message,
  }) async {
    await homeRepo.updateMsg(toldId: toldId, sendTime: sendTime, message: message);
  }

}
