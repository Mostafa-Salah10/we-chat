import 'package:chat_app/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class VerticalSpace extends StatelessWidget {
  final double height;
  const VerticalSpace({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: SizeConfig.blockHeight * height);
  }
}

class HorizontilSpace extends StatelessWidget {
  final double width;
  const HorizontilSpace({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: SizeConfig.blockWidth * width);
  }
}
