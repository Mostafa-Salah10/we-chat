import 'package:chat_app/core/functions/check_internet.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
}
