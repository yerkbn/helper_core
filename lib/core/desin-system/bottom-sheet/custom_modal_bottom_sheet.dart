import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';

void showCustomModalBottomSheet({
  required BuildContext context,
  required Widget child,
  Function(dynamic value)? onEnd,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      final CustomThemeExtension theme = CustomThemeExtension.of(context);
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            color: theme.backgroundColor1,
          ),
          padding: EdgeInsets.only(bottom: 32.h, top: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: 32.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.sp),
                  color: theme.backgroundColor3,
                ),
              ),
              child,
            ],
          ),
        ),
      );
    },
  ).then((value) {
    if (onEnd != null) onEnd(value);
  });
}
