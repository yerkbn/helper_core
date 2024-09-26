import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';
import 'package:helper_core/core/desin-system/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyWidget extends StatelessWidget {
  final void Function()? onTap;

  const EmptyWidget({
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: 42.h,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "Бірінші боп қос!",
              textAlign: TextAlign.center,
              style: theme.headline2,
            ),
            SizedBox(
              height: 8.h,
            ),
            onTap == null
                ? Container()
                : CustomButton.h2(
                    title: "",
                    isLoading: false,
                    isDisabled: false,
                    width: 327.w,
                    onPressed: onTap!)
          ],
        ),
      ),
    );
  }
}
