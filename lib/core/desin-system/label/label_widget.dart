import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';
import 'package:helper_core/core/desin-system/container/custom_container.dart';
import 'package:helper_core/core/local-pub/extension/sizedbox_extension.dart';

class LabelWidget extends StatelessWidget {
  final String text;
  final double height;
  final double? width;
  final IconData? icondata;
  final void Function()? onPressed;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double paddingFactor;

  const LabelWidget(
      {super.key,
      required this.text,
      this.icondata,
      this.height = 24,
      this.paddingFactor = 1,
      this.width,
      this.onPressed,
      this.textColor,
      this.color,
      this.borderColor,
      this.padding});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: CustomContainer(
        height: height.h,
        width: width,
        borderRadiusAll: 6,
        color: color ?? theme.backgroundColor4,
        paddingHorizantal: 8 * paddingFactor,
        onPressed: onPressed,
        paddingVertical: 0,
        topMargin: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icondata != null)
              Icon(
                icondata,
                color: textColor ?? theme.textColor1,
                size: (height / (1.3 * paddingFactor)).h,
              ),
            if (text == "") 0.pw else if (icondata != null) 4.pw,
            Text(
              text,
              style: theme.headline3.copyWith(
                  fontSize: (height / (1.8 * paddingFactor)).sp,
                  color: textColor),
            )
          ],
        ),
      ),
    );
  }
}
