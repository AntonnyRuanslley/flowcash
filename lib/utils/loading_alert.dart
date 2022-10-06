import 'package:flutter/material.dart';
import 'package:cas/themes/app_theme.dart';

loadingDialog(BuildContext context, String msg) {
  showDialog(
      context: context,
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
