import 'package:chat_app/core/enums/requrest_status.dart';
import 'package:chat_app/features/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final AuthRepo authRepo;
  AuthService({required this.authRepo});
  RequestStatus requestStatus = RequestStatus.nothing;
  String errorMessage = '';

  Future<void> signInWithGoogle() async {
    requestStatus = RequestStatus.loading;
    notifyListeners();
    final result = await authRepo.signInWithGoogle();
    result.fold(
      (error) {
        errorMessage = error;
        requestStatus = RequestStatus.failure;
        notifyListeners();
      },
      (user) {
        if (user == null) {
          requestStatus = RequestStatus.nothing;
          notifyListeners();
          return;
        }
        requestStatus = RequestStatus.success;
        notifyListeners();
      },
    );
  }
}
