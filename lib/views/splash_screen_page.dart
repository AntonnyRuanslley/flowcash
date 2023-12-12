import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';
import '../themes/app_theme.dart';

class SplashScreenPage extends GetView<SplashScreenController> {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      controller.initializeApp();
    });
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: CircularProgressIndicator(
          color: AppTheme.secondyColor,
        ),
      ),
    );
  }
}
