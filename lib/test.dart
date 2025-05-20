import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String? appState = '';
  @override
  void initState() {
    SystemChannels.lifecycle.setMessageHandler((message) async {
      setState(() {
        log(message.toString());
        appState = message;
      });
      return null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(appState?.split('.').last ?? '')));
  }
}
