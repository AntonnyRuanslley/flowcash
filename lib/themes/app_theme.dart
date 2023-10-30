import '../utils/screen_size.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = const Color(0XFFB80099);
  static Color secondyColor = const Color(0xFFFFFFFF);
  static Color tertiaryColor = const Color(0xFF000000);

  static TextStyle title1(BuildContext context) {
    return TextStyle(
      fontFamily: "Roboto-Regular",
      fontSize: ScreenSizes.getScreenHeightSize(context) * 0.025,
      fontWeight: FontWeight.normal,
      color: tertiaryColor,
    );
  }

  static TextStyle title2(BuildContext context) {
    return TextStyle(
      fontFamily: "Roboto-Regular",
      fontSize: ScreenSizes.getScreenHeightSize(context) * 0.03,
      fontWeight: FontWeight.bold,
      color: secondyColor,
    );
  }

  static TextStyle subtitle1(BuildContext context) {
    return TextStyle(
      fontFamily: "Roboto-Regular",
      fontSize: ScreenSizes.getScreenHeightSize(context) * 0.03,
      fontWeight: FontWeight.normal,
      color: secondyColor,
    );
  }
}
