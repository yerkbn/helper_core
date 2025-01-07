import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';

class CustomLoading extends StatelessWidget {
  final double progresHeight;
  final double strokeWidth;
  final Color? color;
  final double padding;
  const CustomLoading(
      {super.key,
      this.progresHeight = 24,
      this.color,
      this.padding = 10,
      this.strokeWidth = 3});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Center(
      child: Padding(
          padding: EdgeInsets.all(padding.h),
          child: SizedBox(
            height: progresHeight.h,
            width: progresHeight.h,
            child: CupertinoActivityIndicator(color: color ?? theme.textColor1),
          )

          // CircularProgressIndicator(
          //   valueColor: AlwaysStoppedAnimation(
          //     color,
          //   ),
          //   strokeWidth: strokeWidth,
          // )),
          ),
    );
  }
}
