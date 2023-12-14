import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ButtonOptions {
  const ButtonOptions({
    this.textStyle,
    this.elevation,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.disabledColor,
    this.disabledTextColor,
    this.splashColor,
    this.iconSize,
    this.iconColor,
    this.iconPadding,
    this.borderRadius,
    this.borderSide,
  });

  final TextStyle? textStyle;
  final double? elevation;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final Color? splashColor;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
}

// ignore: must_be_immutable
class ButtonWidget extends StatefulWidget {
  final String text;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final Widget? topIcon;
  Function()? onPressed;
  final ButtonOptions options;
  final bool showLoadingIndicator;
  final int? maxLines;

  ButtonWidget({
    Key? key,
    required this.text,
    this.onPressed,
    this.prefixIcon,
    this.sufixIcon,
    this.topIcon,
    required this.options,
    this.showLoadingIndicator = false,
    this.maxLines,
  }) : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    Widget textWidget = widget.showLoadingIndicator
        ? Center(
            child: SizedBox(
              width: 23,
              height: 23,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.options.textStyle!.color ?? Colors.white,
                ),
              ),
            ),
          )
        : AutoSizeText(
            widget.text,
            style: widget.options.textStyle,
            maxLines: widget.maxLines ?? 1,
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          );

    final onPressed = widget.showLoadingIndicator
        ? () {}
        : widget.onPressed != null
            ? () => widget.onPressed!()
            : null;
    ButtonStyle style = ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius:
              widget.options.borderRadius ?? BorderRadius.circular(8.0),
          side: widget.options.borderSide ?? BorderSide.none,
        ),
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return widget.options.disabledTextColor;
          }
          return widget.options.textStyle!.color;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return widget.options.disabledColor;
          }
          if (widget.onPressed == null) {
            return Colors.grey;
          }
          return widget.options.color;
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.pressed)) {
          return widget.options.splashColor;
        }
        return null;
      }),
      padding: MaterialStateProperty.all(widget.options.padding ??
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)),
      elevation:
          MaterialStateProperty.all<double>(widget.options.elevation ?? 2.0),
    );

    if (widget.prefixIcon != null ||
        widget.sufixIcon != null ||
        widget.topIcon != null) {
      return Container(
        height: widget.options.height,
        width: widget.options.width,
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: 150,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: style,
          child: widget.topIcon == null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.prefixIcon != null) widget.prefixIcon!,
                    if (widget.prefixIcon != null) const SizedBox(width: 10),
                    Flexible(child: textWidget),
                    if (widget.sufixIcon != null) const SizedBox(width: 10),
                    if (widget.sufixIcon != null) widget.sufixIcon!,
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.topIcon!,
                    const SizedBox(height: 10),
                    textWidget,
                  ],
                ),
        ),
      );
    }

    return Material(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: widget.options.borderRadius ?? BorderRadius.circular(8.0),
      ),
      child: Container(
        height: widget.options.height,
        width: widget.options.width,
        constraints: BoxConstraints(maxWidth: 500),
        child: ElevatedButton(
          onPressed: onPressed,
          style: style,
          child: textWidget,
        ),
      ),
    );
  }
}
