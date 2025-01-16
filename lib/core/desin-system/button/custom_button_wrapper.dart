import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_corner/smooth_corner.dart';

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
            :

            // RoundedRectangleBorder(
            //     borderRadius:
            //         borderRadius ?? BorderRadius.circular(borderRadiusAll.r),
            //   ),
            SmoothRectangleBorder(
                borderRadius:
                    borderRadius ?? BorderRadius.circular(borderRadiusAll.r),
                smoothness: 0.6,
              ),
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
