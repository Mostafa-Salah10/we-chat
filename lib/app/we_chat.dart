import 'package:chat_app/core/routes/app_router.dart';
import 'package:chat_app/core/routes/app_routes.dart';
import 'package:chat_app/core/theme/app_theme.dart';
import 'package:chat_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class WeChat extends StatelessWidget {
  const WeChat({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp(
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      // home: Test(),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
