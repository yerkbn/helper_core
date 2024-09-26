import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';
import 'package:helper_core/core/desin-system/images-group/image_item.dart';

class ImagesGroup extends StatelessWidget {
  final List<String>? images;
  final double radius;
  const ImagesGroup({super.key, required this.images, required this.radius});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    if (images == null) return emptyImages(theme);
    if (images!.isEmpty) return emptyImages(theme);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.backgroundColor2,
        borderRadius: BorderRadius.circular(radius.r),
      ),
      child: Stack(
        children: [
          for (int index = 0; index < images!.length; index++) ...[
            ImageItem(
              color: theme.backgroundColor2,
              radius: radius,
              image: images![index],
              index: index,
            ),
          ]
        ],
      ),
    );
  }

  Widget emptyImages(CustomThemeExtension theme) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.backgroundColor2,
        borderRadius: BorderRadius.circular(radius.r),
      ),
      child: Stack(
        children: [
          for (int index = 0; index < 3; index++) ...[
            ImageItem(
              color: theme.backgroundColor2,
              radius: radius,
              image: "",
              index: index,
            ),
          ]
        ],
      ),
    );
  }
}
