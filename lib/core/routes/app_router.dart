import 'package:chat_app/core/routes/app_routes.dart';
import 'package:chat_app/features/home/presentation/screens/home_view.dart';
import 'package:chat_app/features/splash/presentation/screens/splash_view.dart';
import 'package:flutter/material.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashView());

      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return null;
    }
  }
}
