import 'package:flutter/material.dart';

alertDialog(
  BuildContext context,
  String? msg,
) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
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
