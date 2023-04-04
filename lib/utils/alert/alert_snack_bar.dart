import 'package:flutter/material.dart';

alertSnackBar({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: backgroundColor,
    ),
  );
}
