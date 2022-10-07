import 'package:cas/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final String label;

  const CustomTitle({
    Key? key,
    required this.icon,
    required this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: ScreenSizes.getScreenHeightSize(context) * 0.04,
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenSizes.getScreenHeightSize(context) * 0.029,
          ),
        ),
      ],
    );
  }
}
