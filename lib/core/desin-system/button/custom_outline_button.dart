import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlineButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final bool isWidthOff; // width will be determined based on content
  final bool isTextButton;
  final VoidCallback onPressed;
  final double fontSize;
  final double width;
  final double height;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final BorderRadius? radius;

  const CustomOutlineButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.width,
    required this.height,
    this.color,
    this.isLoading = false,
    this.isTextButton = false,
    this.isWidthOff = false,
    this.fontSize = 16,
    this.textColor = Colors.black,
    this.borderColor = Colors.black,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isWidthOff ? null : width.w,
      height: height.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: color ?? Colors.white,
          overlayColor: textColor ?? Colors.black,
          shadowColor: textColor ?? Colors.black,
          side: BorderSide(color: borderColor ?? Colors.black, width: 2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: textColor ?? Colors.black, // Text color
              fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
