import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_theme.dart';
import '../../widgets/custom/button_base.dart';

Future<dynamic> alertDialog({
  required String title,
  String? subtitle,
  String? buttonLabel,
  Function()? function,
}) async {
  if (Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
  }
  return await showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: AppTheme.title1(context).copyWith(
            fontWeight: subtitle != null ? FontWeight.w500 : FontWeight.w400,
            fontSize: subtitle != null ? 21 : 20,
          ),
        ),
        content: subtitle != null
            ? Text(
                subtitle,
                style: AppTheme.title2(context).copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 19,
                ),
              )
            : null,
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ButtonBase(
              label: buttonLabel ?? 'Ok',
              height: 40,
              width: 100,
              onPressed: () {
                Get.back();
                if (function != null) function();
              },
            ),
          ),
        ],
      );
    },
  );
}
