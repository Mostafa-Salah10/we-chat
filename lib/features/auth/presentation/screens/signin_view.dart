import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/assets.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/core/widgets/app_spaces.dart';
import 'package:chat_app/features/auth/presentation/widgets/custom_signin_with_google_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.welcome,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Column(
        children: [
          Spacer(),
          Center(child: _getLogoImage()),
          Spacer(),
          CustomSignInWithGoogleButton(
            onPressed: () {},
          ).animate().fade(duration: 700.ms).moveY(duration: 700.ms, begin: 20),
          VerticalSpace(height: 10),
        ],
      ),
    );
  }

  Widget _getLogoImage() {
    return Image.asset(
      Assets.imagesLogoApp,
      width: SizeConfig.blockHeight * 20,
      height: SizeConfig.blockHeight * 20,
    ).animate().fade(duration: 700.ms).moveX(duration: 700.ms, begin: 20);
  }
}
