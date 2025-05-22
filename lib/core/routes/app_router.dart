import 'package:chat_app/core/routes/app_routes.dart';
import 'package:chat_app/features/auth/presentation/screens/signin_view.dart';
import 'package:chat_app/features/home/data/models/user_model.dart';
import 'package:chat_app/features/home/presentation/screens/chat_view.dart';
import 'package:chat_app/features/home/presentation/screens/detail_veiw.dart';
import 'package:chat_app/features/home/presentation/screens/home_view.dart';
import 'package:chat_app/features/profile/presentation/screens/profile_view.dart';
import 'package:chat_app/features/splash/presentation/screens/splash_view.dart';
import 'package:flutter/material.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashView());

      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeView());

      case AppRoutes.signInScreen:
        return MaterialPageRoute(builder: (_) => SignInView());
      case AppRoutes.chatScreen:
        final UserModel user = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (_) => ChatView(userModel: user));
      case AppRoutes.profileScreen:
        final UserModel user = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (_) => ProfileView(user: user));
      case AppRoutes.detailsScreen:
        final UserModel user = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (_) => DetailsView(user: user));
      default:
        return null;
    }
  }
}
