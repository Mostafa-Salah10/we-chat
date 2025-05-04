import 'package:chat_app/core/functions/custom_navigator.dart';
import 'package:chat_app/core/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_strings.dart';
import 'package:chat_app/core/utils/assets.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:chat_app/core/widgets/app_spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    _navigateToAnotherScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Center(child: _getImageLogo()),
          Spacer(),
          Text(
            AppStrings.appName,
            style: Theme.of(context).textTheme.headlineMedium,
          ).animate().fade(duration: 700.ms).moveY(duration: 700.ms, begin: 20),

          VerticalSpace(height: 7),
        ],
      ),
    );
  }

  Widget _getImageLogo() {
    return Image.asset(
          Assets.imagesLogoApp,
          width: SizeConfig.blockHeight * 20,
          height: SizeConfig.blockHeight * 20,
        )
        .animate()
        .fade(duration: 800.ms)
        .scale(duration: 800.ms, begin: Offset(0, 0));
  }

  Future<void> _navigateToAnotherScreen() {
    return Future.delayed(
      const Duration(seconds: 3),
      () => customPushReplacement(context, route: AppRoutes.signInScreen),
    );
  }
}
