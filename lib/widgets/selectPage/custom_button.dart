import 'package:flutter/material.dart';

import '../../../themes/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double height;
  final double width;
  const CustomButton({
    Key? key,
    required this.label,
    required this.height,
    required this.width,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppTheme.secondyColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: AppTheme.subtitle1(context).copyWith(
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
