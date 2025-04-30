import 'package:flutter/material.dart';

class WeChat extends StatelessWidget {
  const WeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: Text('WeChat'))),
    );
  }
}
