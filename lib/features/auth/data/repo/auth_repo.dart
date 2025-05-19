import 'package:chat_app/core/constants/firebase_cons.dart';
import 'package:chat_app/core/functions/check_internet.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  //sign in with google
  Future<Either<String, UserCredential?>> signInWithGoogle() async {
    try {
      if (!await checkInternetConnection()) {
        return Left(AppStrings.internetConnection);
      }
      //step 1 => select google account from device
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Right(null);
      } else {
        //step 2 => get token of google account
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        //step 3 => make credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        //step 4 => sign in with credential
        return Right(await _auth.signInWithCredential(credential));
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  //create user if not sign in before
  static Future<void> createUser() async {
    final UserModel userModel = _user;

    _fireStore
        .collection(FireBaseConstants.users)
        .doc(userModel.id)
        .set(userModel.toJson());
  }

  static UserModel get _user {
    final User u = _auth.currentUser!;
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    return UserModel(
      email: u.email.toString(),
      name: u.displayName.toString(),
      id: u.uid,
      isOnline: false,
      about: AppStrings.defAbout,
      image: u.photoURL.toString(),
      pushToken: '',
      createdAt: time,
      lastActive: time,
    );
  }
}
