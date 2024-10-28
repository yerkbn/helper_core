import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helper_core/core/desin-system/button/custom_button_wrapper.dart';
import 'package:helper_core/core/desin-system/states/loading/custom_loading.dart';
import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final bool isDisabled;
  final bool isWidthOff; // width will be determined based on content
  final bool isTextButton;
  final void Function() onPressed;

  // Size with no ScreenUtil
  final double width;
  final double height;
  final double progresHeight;
  final double borderRadius;
  final double fontSize;
  // optional
  final Widget? child;
  final Color? color;
  final Color? textColor;
  final Color? disabledTextColor;
  final BorderRadius? fullBorderRadius;

  const CustomButton({
    required this.title,
    required this.isLoading,
    required this.isDisabled,
    required this.onPressed,
    required this.width,
    required this.height,
    this.color,
    this.isTextButton = false,
    this.isWidthOff = false,
    this.progresHeight = 24,
    this.fontSize = 17,
    this.textColor = Colors.white,
    this.borderRadius = 16,
    this.fullBorderRadius,
    this.disabledTextColor,
    this.child,
  });

  factory CustomButton.textBtn(
      {required String title,
      required void Function() onPressed,
      bool isLoading = false,
      bool isDisabled = false,
      double width = 327,
      double height = 34,
      double fontSize = 17,
      Color? color,
      Color? textColor = Colors.white,
      Widget? child}) {
    return CustomButton(
      title: title,
      isLoading: isLoading,
      isDisabled: isDisabled,
      onPressed: onPressed,
      width: width,
      color: color,
      textColor: textColor,
      height: height,
      fontSize: fontSize,
      isTextButton: true,
      child: child,
    );
  }

  factory CustomButton.h1({
    required String title,
    required void Function() onPressed,
    double width = 327,
    double height = 56,
    bool isLoading = false,
    bool isDisabled = false,
    bool isWidthOff = false,
    Color? textColor = Colors.white,
    Color? disabledTextColor,
    Color? color,
    Widget? child,
    double? borderRadius,
    BorderRadius? fullBorderRadius,
  }) {
    return CustomButton(
      title: title,
      isLoading: isLoading,
      isDisabled: isDisabled,
      isWidthOff: isWidthOff,
      onPressed: onPressed,
      borderRadius: borderRadius ?? 12,
      width: width,
      height: height,
      color: color,
      textColor: textColor,
      fullBorderRadius: fullBorderRadius,
      disabledTextColor: disabledTextColor,
      child: child,
    );
  }

  factory CustomButton.h2(
      {required String title,
      required void Function() onPressed,
      double width = 327,
      double height = 42,
      double fontSize = 16,
      bool isLoading = false,
      bool isDisabled = false,
      bool isWidthOff = false,
      double borderRadius = 12,
      Color? textColor = Colors.white,
      Color? disabledTextColor,
      Color? color,
      Widget? child}) {
    return CustomButton(
      title: title,
      isLoading: isLoading,
      isDisabled: isDisabled,
      isWidthOff: isWidthOff,
      onPressed: onPressed,
      width: width,
      height: height,
      borderRadius: borderRadius,
      fontSize: fontSize,
      color: color,
      textColor: textColor,
      disabledTextColor: disabledTextColor,
      child: child,
    );
  }

  factory CustomButton.h3({
    required String title,
    required void Function() onPressed,
    double width = 327,
    double height = 24,
    double fontSize = 12,
    bool isLoading = false,
    bool isDisabled = false,
    bool isWidthOff = false,
    Color? textColor = Colors.white,
    Color? color,
    Widget? child,
  }) {
    return CustomButton(
      title: title,
      isLoading: isLoading,
      isDisabled: isDisabled,
      isWidthOff: isWidthOff,
      onPressed: onPressed,
      width: width,
      height: height,
      progresHeight: 12,
      borderRadius: 6,
      fontSize: fontSize,
      color: color,
      textColor: textColor,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);

    final Widget elevatedBtn = ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.black12),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return color ?? theme.backgroundColor4;
            }
            return color ?? theme.primaryColor;
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius:
                  fullBorderRadius ?? BorderRadius.circular(borderRadius.h),
            ),
          ),
        ),
        child: _buildChild(
            context: context,
            primaryColor: textColor ?? Colors.white,
            theme: theme));

    final Widget textBtn = CustomButtonWrapper(
        onPressed: isDisabled ? null : onPressed,
        foregroundColor: color,
        borderRadiusAll: 12,
        child: isLoading
            ? CustomLoading(
                progresHeight: progresHeight,
                strokeWidth: 1,
                color: textColor ?? Colors.white,
              )
            : Text(
                title,
                textAlign: TextAlign.center,
                style: theme.headline2.copyWith(
                  fontSize: fontSize.h,
                  color: isDisabled ? theme.backgroundColor1 : textColor,
                ),
              ));

    return SizedBox(
      width: isWidthOff ? null : width.w,
      height: height.h,
      child: isTextButton ? textBtn : elevatedBtn,
    );
  }

  Widget _buildChild(
      {required BuildContext context,
      required Color primaryColor,
      required CustomThemeExtension theme}) {
    final TextStyle style = fontSize < 14 ? theme.headline3 : theme.headline2;
    return isLoading
        ? CustomLoading(
            progresHeight: progresHeight,
            strokeWidth: 2,
            padding: 0,
            color: textColor!,
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: isWidthOff ? 10.w : 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (child == null) const SizedBox() else child!,
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                    fontSize: fontSize.h,
                    color: isDisabled
                        ? disabledTextColor ?? theme.backgroundColor2
                        : primaryColor,
                  ),
                ),
              ],
            ),
          );
  }
}
