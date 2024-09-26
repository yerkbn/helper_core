import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:helper_core/core/desin-system/states/loading/custom_loading.dart';

class CustomImageWidget extends StatelessWidget {
  final String url;
  final double borderRadius;
  final double? width;
  final double? height;
  const CustomImageWidget({
    super.key,
    required this.url,
    this.borderRadius = 0,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: SizedBox(
        width: width,
        height: height,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(child: CustomLoading()),
          errorWidget: (context, url, error) {
            return const ColoredBox(
              color: Colors.grey,
              child: Center(child: Icon(Icons.error)),
            );
          },
        ),
      ),
    );
  }
}
