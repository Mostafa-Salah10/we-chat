import 'package:chat_app/core/enums/requrest_status.dart';
import 'package:chat_app/core/functions/custom_navigator.dart';
import 'package:chat_app/core/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/widgets/custom_dialogs.dart';
import 'package:chat_app/features/auth/presentation/manager/auth_service.dart';
import 'package:chat_app/features/auth/presentation/widgets/custom_signin_with_google_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class HandelSignInButton extends StatelessWidget {
  const HandelSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, value, _) {
        _handelRequest(value, context);
        return CustomSignInWithGoogleButton(
          onPressed: () async {
            await context.read<AuthService>().signInWithGoogle();
          },
        ).animate().fade(duration: 700.ms).moveY(duration: 700.ms, begin: 20);
      },
    );
  }

  void _handelRequest(AuthService value, BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (value.requestStatus == RequestStatus.loading) {
        CustomDialogs.showCircleProgressIndicatorDialog(context: context);
      } else {
        _dismissDialog(context);
        if (value.requestStatus == RequestStatus.failure) {
          CustomDialogs.showSnackBar(
            context: context,
            msg: value.errorMessage,
            color: AppColors.red,
          );
        } else if (value.requestStatus == RequestStatus.success) {
          customPushReplacement(context, route: AppRoutes.homeScreen);
        }
      }
    });
  }

  void _dismissDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
