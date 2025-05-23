import 'package:chat_app/app/we_chat.dart';
import 'package:chat_app/core/functions/get_providers.dart';
import 'package:chat_app/core/functions/init_serveces_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Firebase.initializeApp(),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]);
  initServecesApp();
  runApp(MultiProvider(providers: getProviders, child: WeChat()));
}
