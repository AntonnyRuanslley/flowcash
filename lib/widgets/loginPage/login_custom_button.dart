import 'package:cas/utils/screen_size.dart';
import 'package:flutter/material.dart';

class LoginCustomButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  const LoginCustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSizes.getScreenHeightSize(context) * 0.06,
      width: ScreenSizes.getScreenHeightSize(context) * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.green[800],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: ScreenSizes.getScreenHeightSize(context) * 0.027,
                  color: Colors.white,
                ),
              ),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
