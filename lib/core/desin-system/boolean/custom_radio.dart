import 'package:flutter/material.dart';
import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';

class CustomRadio extends StatelessWidget {
  final bool value;
  final void Function(bool? val) onChanged;
  const CustomRadio({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Radio(
      value: value,
      groupValue: true,
      onChanged: onChanged,
      overlayColor: WidgetStateProperty.all(theme.primaryColor),
      fillColor: WidgetStateProperty.all(theme.primaryColor),
      activeColor: theme.primaryColor,
    );
  }
}
