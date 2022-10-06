import 'package:cas/themes/app_theme.dart';
import 'package:flutter/material.dart';

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
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: AppTheme.subtitle1(context),
        ),
      ),
    );
  }
}
