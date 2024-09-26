import 'package:flutter/material.dart';

class CustomButtonWrapper extends StatelessWidget {
  final Widget child;
  final bool isCircle;
  final double borderRadiusAll;
  final BorderRadiusGeometry? borderRadius;

  final Function()? onPressed;
  final Color? color;
  final Color? foregroundColor;
  const CustomButtonWrapper({
    super.key,
    required this.child,
    required this.onPressed,
    this.color,
    this.foregroundColor,
    this.borderRadiusAll = 0,
    this.borderRadius,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: isCircle
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: borderRadius ??
                    BorderRadius.all(Radius.circular(borderRadiusAll))),
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        foregroundColor: foregroundColor ?? Colors.black12,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: color,
      ),
      child: child,
    );
  }
}
