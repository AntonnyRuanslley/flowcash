import 'package:cas/themes/app_theme.dart';
import 'package:flutter/material.dart';

void snackBarAlertII({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
}) {
  showModalBottomSheet<void>(
    context: context,
    barrierColor: const Color.fromRGBO(0, 0, 0, 0),
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 5), () {
        try {
          Navigator.pop(context);
        } on Exception {}
      });
      return Container(
        color: backgroundColor ?? AppTheme.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      );
    },
  );
}
