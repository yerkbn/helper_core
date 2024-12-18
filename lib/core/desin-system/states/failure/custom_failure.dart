import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';
import 'package:helper_core/core/desin-system/button/custom_button.dart';
import 'package:helper_core/core/local-pub/extension/sizedbox_extension.dart';

enum FailureStatus { h1, h2, h3 }

class CustomFailure extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Function()? onTap;
  final FailureStatus status;
  final String btnTitle;
  final String image;

  const CustomFailure({
    super.key,
    this.onTap,
    this.title = "Oops, unknown error!",
    this.btnTitle = "Refresh",
    this.subtitle,
    this.status = FailureStatus.h1,
    this.image = "", //ImageAsset.error,
  });

  double get getHeight {
    if (status == FailureStatus.h2) return 20.h;
    if (status == FailureStatus.h3) return 40.h;
    return 80.h;
  }

  double get getFontSize {
    if (status == FailureStatus.h2) return 10.h;
    if (status == FailureStatus.h3) return 12.h;
    return 14.h;
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Align(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: theme.backgroundColor3),
              width: getHeight,
              padding: EdgeInsets.all(12.h),
              // child: Assets.icons.fire.svg(),
            ),
            SizedBox(
              height: getFontSize,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.headline1.copyWith(
                fontSize: getFontSize,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              subtitle ?? "Refresh the page.",
              textAlign: TextAlign.center,
              style: theme.headline4.copyWith(
                fontSize: getFontSize - 4,
              ),
            ),
            8.ph,
            if (onTap == null)
              const SizedBox()
            else
              CustomButton.h3(
                width: 184.w,
                height: 32,
                title: btnTitle,
                onPressed: onTap!,
                color: theme.backgroundColor4,
                fontSize: getFontSize,
              )
          ],
        ),
      ),
    );
  }
}
