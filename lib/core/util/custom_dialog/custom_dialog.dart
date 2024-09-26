import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';
import 'package:helper_core/core/desin-system/button/custom_button.dart';
import 'package:helper_core/core/desin-system/container/custom_container.dart';
import 'package:helper_core/core/util/custom_dialog/custom_dialog_data.dart';

class CustomDialog extends StatefulWidget {
  final CustomDialogData data;
  final bool isDismissible;
  const CustomDialog({
    super.key,
    required this.data,
    required this.isDismissible,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  CustomDialogData get data => widget.data;

  @override
  Widget build(BuildContext context) {
    return widget.isDismissible
        ? GestureDetector(
            onTap: () => Navigator.pop(context),
            child: child,
          )
        : child;
  }

  Widget get child {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: CustomContainer(
          width: 300.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(data.image, height: 80.h),
              SizedBox(height: 14.h),
              Text(
                data.title,
                style: theme.headline2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 14.h),
              CustomButton.h2(
                title: data.btnText,
                color: theme.backgroundColor4,
                onPressed: data.onBtnPressed,
                isLoading: data.isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
