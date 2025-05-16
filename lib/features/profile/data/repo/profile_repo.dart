import 'package:chat_app/core/constants/firebase_cons.dart';
import 'package:chat_app/core/functions/check_internet.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Future<Either<String, Null>> updateProfile({
    required String name,
    required String about,
  }) async {
    try {
      if (!await checkInternetConnection()) {
        return Left(AppStrings.internetConnection);
      }
      await _fireStore
          .collection(FireBaseConstants.users)
          .doc(_auth.currentUser!.uid)
          .update({
            FireBaseConstants.name: name,
            FireBaseConstants.about: about,
          });
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
