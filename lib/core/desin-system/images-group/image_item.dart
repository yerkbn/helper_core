import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageItem extends StatelessWidget {
  final String image;
  final double radius;
  final int index;
  final Color color;
  const ImageItem({
    super.key,
    required this.image,
    required this.radius,
    required this.index,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: (index * radius * 2) - (radius * .6 * index)),
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100.r),
        ),
        padding: EdgeInsets.all(radius * .2),
        child: CircleAvatar(
          backgroundColor: Colors.white12,
          backgroundImage: image == "" ? null : NetworkImage(image),
        ),
      ),
    );
  }
}
