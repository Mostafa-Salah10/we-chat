import 'package:flutter/material.dart';

abstract class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;
  static late double textSize;

  static void init(BuildContext context) {
    screenWidth = isLandScape(context)
        ? MediaQuery.of(context).size.height
        : MediaQuery.of(context).size.width;
    screenHeight = isLandScape(context)
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;
    blockHeight = screenHeight / 100;
    blockWidth = screenWidth / 100;
    textSize = blockHeight;
  }

  static bool isLandScape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static bool get isMobile => screenWidth <= 450.0;
  static bool get isTablet => screenWidth > 450.0 && screenWidth < 800;
  static bool get isDesktop => screenWidth >= 800.0;

  static T valueDecide<T>({
    required T onMobile,
    required T onTablet,
    required T onsDesktop,
  }) {
    if (isMobile) {
      return onMobile;
    } else if (isTablet) {
      return onTablet;
    } else {
      return onsDesktop;
    }
  }
}
