import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../themes/app_theme.dart';
import '../../../utils/screen_size.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenWidthSize(context);

    return TextField(
      maxLines: 1,
      cursorColor: AppTheme.secondyColor,
      style: TextStyle(
        color: AppTheme.secondyColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: sizeScreen * 0.05,
          color: Colors.white54,
        ),
        contentPadding: EdgeInsets.only(
            left: sizeScreen * 0.05,
            top: sizeScreen * 0.041,
            bottom: sizeScreen * 0.041,
            right: sizeScreen * 0.05),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(sizeScreen * 0.04),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(sizeScreen * 0.04),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
    );
  }
}
