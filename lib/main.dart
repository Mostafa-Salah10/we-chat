import 'package:chat_app/app/we_chat.dart';
import 'package:chat_app/core/functions/init_serveces_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([initServecesApp(), Firebase.initializeApp()]);
  runApp(WeChat());
}
