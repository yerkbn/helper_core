import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';
import 'package:helper_core/core/desin-system/page_switcher/switch_data.dart';

class CustomPageSwitcher extends StatelessWidget {
  final List<SwitchData> items;
  final SwitchData selectedValue;
  final Function(SwitchData) onSelected;
  const CustomPageSwitcher({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Container(
      width: double.infinity,
      height: 36.h,
      decoration: BoxDecoration(
        color: theme.backgroundColor3,
        borderRadius: BorderRadius.circular(8.h),
      ),
      padding: EdgeInsets.all(3.sp),
      child: Row(
        children: [
          ...items.map((e) => _buildItem(e, theme)).toList(),
        ],
      ),
    );
  }

  Widget _buildItem(SwitchData model, CustomThemeExtension theme) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onSelected(model);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: model.value == selectedValue.value
                ? theme.backgroundColor4
                : null,
            borderRadius: BorderRadius.circular(6.sp),
          ),
          child: Center(
            child: Text(
              model.title,
              style: model.value == selectedValue.value
                  ? theme.headline3.copyWith(color: Colors.white)
                  : theme.headline4,
            ),
          ),
        ),
      ),
    );
  }
}
