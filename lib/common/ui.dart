import 'package:flowcash/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ui {
  static GetSnackBar successSnackBar({
    String title = 'Sucesso',
    required String message,
  }) {
    Get.log("[$title] $message");

    return GetSnackBar(
      titleText: Text(
        title,
        style: AppTheme.subtitle1(Get.context!).copyWith(
          color: AppTheme.secondyColor,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(color: AppTheme.secondyColor),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      backgroundColor: AppTheme.alternate,
      icon: Icon(
        Icons.check_circle_outline,
        size: 32,
        color: AppTheme.secondyColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: Duration(seconds: 2),
    );
  }

  static GetSnackBar errorSnackBar({
    String title = 'Erro',
    required String message,
  }) {
    Get.log("[$title] $message", isError: true);
    if (Get.isSnackbarOpen) {
      Get.back();
    }
    return GetSnackBar(
      titleText: Text(
        title,
        style: AppTheme.subtitle1(Get.context!).copyWith(
          color: AppTheme.secondyColor,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(color: AppTheme.secondyColor),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: Icon(
        Icons.remove_circle_outline,
        size: 32,
        color: AppTheme.secondyColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 2),
    );
  }
}
