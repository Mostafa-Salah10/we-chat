import 'package:chat_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(AppStrings.appName, style: TextStyle(fontSize: 30))
            .animate()
            .move(duration: 400.ms, begin: Offset(0, 30), curve: Curves.easeOut)
            .fadeIn(duration: 800.ms),
      ),
    );
  }
}
