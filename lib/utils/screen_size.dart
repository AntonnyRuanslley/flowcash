import 'package:flutter/material.dart';

class ScreenSizes {
  static getScreenHeightSize(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static getScreenWidthSize(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getDeviceStatucBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }
}
