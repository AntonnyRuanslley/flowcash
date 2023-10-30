import 'package:flutter/material.dart';

import '../../../utils/screen_size.dart';

class CustomValue extends StatelessWidget {
  final Color? color;
  final String label;

  const CustomValue({
    Key? key,
    required this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: ScreenSizes.getScreenHeightSize(context) * 0.029,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
