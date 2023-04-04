import 'package:cas/themes/app_theme.dart';
import 'package:flutter/material.dart';

alertDialog(
  BuildContext context,
  String? msg,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            msg ?? 'Error',
            style: AppTheme.title1(context),
          ),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      });
}
