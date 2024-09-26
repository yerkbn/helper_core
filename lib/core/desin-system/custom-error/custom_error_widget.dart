import 'package:flutter/material.dart';
import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? text;
  const CustomErrorWidget({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Center(
      child: Text(
        text ?? 'Возникли ошибки, попробуйте попозже',
        style: theme.headline1,
      ),
    );
  }
}
