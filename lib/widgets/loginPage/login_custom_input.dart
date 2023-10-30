import 'package:flutter/material.dart';

import '../../utils/screen_size.dart';

class LoginCustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final double heightTextFild;
  final String? Function(String?)? validator;
  final bool obscureText;
  const LoginCustomInput({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    required this.heightTextFild,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSizes.getScreenHeightSize(context) * heightTextFild,
      child: TextFormField(
        maxLines: 1,
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: ScreenSizes.getScreenHeightSize(context) * 0.03,
          ),
          contentPadding: EdgeInsets.only(
            left: ScreenSizes.getScreenWidthSize(context) * 0.06,
            right: ScreenSizes.getScreenWidthSize(context) * 0.06,
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          errorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
