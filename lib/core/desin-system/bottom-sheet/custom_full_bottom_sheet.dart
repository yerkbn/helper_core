import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';

abstract class CustomFullBottomSheet {
  static ModalBottomSheetRoute<T> buildRoute<T>({
    required Widget child,
    required BuildContext context,
    bool isDismissible = true,
    bool isScratch = false,
    Color? modalColor,
  }) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return ModalBottomSheetRoute<T>(
      isScrollControlled: true,
      useSafeArea: true,
      modalBarrierColor: modalColor ?? theme.backgroundColor2,
      // backgroundColor: theme.backgroundColor3,
      isDismissible: isDismissible,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) => isScratch
          ? child
          : Container(
              color: theme.backgroundColor2,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  child,
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Container(
                      width: 60.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: theme.textColor2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
