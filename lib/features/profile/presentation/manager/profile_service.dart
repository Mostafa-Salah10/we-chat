import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:chat_app/features/profile/data/repo/profile_repo.dart';
import 'package:flutter/material.dart';

class ProfileService with ChangeNotifier {
  final ProfileRepo _profileRepo;
  String name = '';
  String about = '';
  final formKey = GlobalKey<FormState>();

  ProfileService({required profileRepo}) : _profileRepo = profileRepo;

  //update profile Info
  Future<UserModel?> updateUserProfile({required UserModel user}) async {
    final res = await _profileRepo.updateProfile(name: name, about: about);
    return res.fold(
      (e) => null,
      (_) => user.copyWith(name: name, about: about),
    );
  }
}
