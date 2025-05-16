import 'dart:io';

import 'package:chat_app/core/constants/firebase_cons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

abstract class GlobalRepo {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static bool checkCurrentUser() => _auth.currentUser != null;
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  static Future<bool> checkCurrentUserExists() async {
    return (await _fireStore
            .collection(FireBaseConstants.users)
            .doc(_auth.currentUser!.uid)
            .get())
        .exists;
  }

  //Teke Photo From Mobile
  static  Future<File?> getImageFromMobile({required bool fromGallary}) async {
    ImagePicker imagePicke = ImagePicker();
    if (fromGallary) {
      XFile? xFile = await imagePicke.pickImage(source: ImageSource.gallery);
      return xFile == null ? null : File(xFile.path);
    } else {
      XFile? xFile = await imagePicke.pickImage(source: ImageSource.camera);
      return xFile == null ? null : File(xFile.path);
    }
  }
}
