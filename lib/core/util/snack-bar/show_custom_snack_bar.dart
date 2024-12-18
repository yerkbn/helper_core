import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';
import 'package:helper_core/core/local-pub/extension/sizedbox_extension.dart';

enum CustomSnackBarType { success, failure, warning }

extension CustomSnackBarColor on CustomSnackBarType {
  Color get getColor {
    switch (this) {
      case CustomSnackBarType.success:
        return Colors.green;
      case CustomSnackBarType.failure:
        return const Color(0xFFF44336);
      case CustomSnackBarType.warning:
        return Colors.orange;
    }
  }

  IconData get getIconData {
    switch (this) {
      case CustomSnackBarType.success:
        return Icons.check_circle;
      case CustomSnackBarType.failure:
        return Icons.close_rounded;
      case CustomSnackBarType.warning:
        return Icons.check_circle;
    }
  }
}

void showCustomSnackBar({
  required BuildContext context,
  required CustomSnackBarType type,
  required String title,
}) {
  final CustomThemeExtension theme = CustomThemeExtension.of(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            type.getIconData,
            color: theme.backgroundColor1,
          ),
          10.pw,
          Text(title, style: theme.headline2.copyWith(color: Colors.white)),
        ],
      ),
      duration: const Duration(milliseconds: 1000),
      width: 343.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      behavior: SnackBarBehavior.floating,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: theme.backgroundColor4,
    ),
  );
}
