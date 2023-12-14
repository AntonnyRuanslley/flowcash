import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/app_theme.dart';

Future<dynamic> loadingDialog({
  required String msg,
}) async {
  if (Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
  }
  return await showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                msg,
                style: AppTheme.title1(context),
              ),
            ],
          ),
        );
      });
}
