import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> openForm(
  Widget widget,
) async {
  if (Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
  }
  return await showDialog(
    context: Get.context!,
    builder: (context) {
      return Center(
        child: widget,
      );
    },
  );
}
