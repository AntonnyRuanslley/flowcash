import 'package:flutter/material.dart';

alertSnackBar(BuildContext context, String msg, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
      ),
      backgroundColor: backgroundColor,
    ),
  );
}
