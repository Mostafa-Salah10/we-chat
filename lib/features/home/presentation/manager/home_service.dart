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

  void update(bool value) {
    isSearch = value;
    notifyListeners();
  }

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
}
