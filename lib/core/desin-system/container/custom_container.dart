import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';
import 'package:helper_core/core/desin-system/button/custom_button_wrapper.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double? paddingVertical;
  final double? paddingHorizantal;
  final double? paddingSize;
  final Color? color;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final Color? foregroundColor;
  final double? width;
  final double? height;
  final double minHeight;
  final double topMargin;
  final double borderRadiusAll;
  final void Function()? onPressed;
  final BoxConstraints? constraints;

  const CustomContainer({
    super.key,
    required this.child,
    this.color,
    this.onPressed,
    this.width,
    this.height,
    this.minHeight = 0,
    this.topMargin = 0,
    this.paddingHorizantal,
    this.paddingSize,
    this.borderRadiusAll = 12,
    this.border,
    this.borderRadius,
    this.paddingVertical,
    this.constraints,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    Widget resultChild = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingSize ?? paddingHorizantal ?? 16.w,
        vertical: paddingSize ?? paddingVertical ?? 16.h,
      ),
      child: child,
    );
    if (onPressed != null) {
      resultChild = CustomButtonWrapper(
        onPressed: onPressed,
        foregroundColor: foregroundColor,
        borderRadius: borderRadius,
        borderRadiusAll: borderRadiusAll,
        child: resultChild,
      );
    }
    return Container(
      width: width?.w,
      height: height?.h,
      constraints: constraints ?? BoxConstraints(minHeight: minHeight.h),
      margin: EdgeInsets.only(top: topMargin.h),
      decoration: border == null
          ? ShapeDecoration(
              color: color ?? theme.backgroundColor2,
              shape: RoundedRectangleBorder(
                borderRadius:
                    borderRadius ?? BorderRadius.circular(borderRadiusAll.r),
              ),

              // SmoothRectangleBorder(
              //     borderRadius:
              //         borderRadius ?? BorderRadius.circular(borderRadiusAll.h),
              //     smoothness: 0.6),
            )
          : BoxDecoration(
              border: border,
              borderRadius:
                  borderRadius ?? BorderRadius.circular(borderRadiusAll.h),
              color: color ?? theme.backgroundColor2,
            ),
      child: resultChild,
    );
  }
}
