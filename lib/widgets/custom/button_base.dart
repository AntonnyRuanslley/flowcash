import 'package:flowcash/themes/custom_button.dart';
import 'package:flowcash/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ButtonBase extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final Widget? sufixIcon;
  final Widget? prefixIcon;
  final Widget? topIcon;
  final bool? showLoadingIndicator;
  final double? width;
  final double? height;
  final Color? buttonColor;
  final Color? labelColor;
  final double? elevation;
  final int? maxLines;
  final BorderRadius? borderRadius;
  const ButtonBase({
    super.key,
    required this.label,
    required this.onPressed,
    this.sufixIcon,
    this.prefixIcon,
    this.topIcon,
    this.showLoadingIndicator = false,
    this.width = double.infinity,
    this.height = 45,
    this.buttonColor = const Color(0XFFB80099),
    this.labelColor = Colors.white,
    this.elevation,
    this.maxLines,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      text: label,
      showLoadingIndicator: showLoadingIndicator!,
      sufixIcon: sufixIcon,
      prefixIcon: prefixIcon,
      topIcon: topIcon,
      maxLines: maxLines,
      options: ButtonOptions(
        width: width,
        height: height,
        color: buttonColor,
        elevation: elevation,
        textStyle: AppTheme.subtitle1(context).copyWith(
          color: labelColor,
          fontWeight: FontWeight.normal,
        ),
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      onPressed: onPressed,
    );
  }
}
