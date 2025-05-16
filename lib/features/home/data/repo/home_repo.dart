import 'package:chat_app/core/constants/firebase_cons.dart';
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
}
