import 'package:flutter/material.dart';

class AppHelper {
  static bool isTabletSmall() {
    final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
    return data.size.shortestSide <= 640 && data.size.shortestSide > 500;
  }

  static bool isTablet() {
    final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
    return data.size.shortestSide > 640;
  }
}
