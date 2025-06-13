import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final bool outlined;

  const GenericButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.outlined = false,
    this.icon,
    this.padding,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final btnChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          IconTheme(
              data: IconThemeData(color: textColor, size: fontSize ?? 16),
              child: icon!),
          const SizedBox(width: 8)
        ],
        Text(
          text,
          style: TextStyle(color: textColor, fontSize: fontSize ?? 16),
        ),
      ],
    );

    if (outlined) {
      return SizedBox(
        width: width,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: textColor),
            padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: btnChild,
        ),
      );
    } else {
      return SizedBox(
        width: width,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              padding: padding ?? EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: btnChild),
      );
    }
  }
}
