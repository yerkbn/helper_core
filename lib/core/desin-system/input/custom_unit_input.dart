import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension TextEditingControllerExt on TextEditingController {
  void selectAll() {
    if (text.isEmpty) return;
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}

class CustomUnitInput extends StatelessWidget {
  final String initVal;
  final TextAlign align;
  final int minLines;
  final int maxLines;
  final Function(String) onChange;

  CustomUnitInput({
    Key? key,
    required this.initVal,
    required this.onChange,
    this.minLines = 1,
    this.maxLines = 1,
    this.align = TextAlign.left,
  }) : super(key: key);

  late final TextEditingController _controller =
      TextEditingController(text: initVal);

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length));
    return TextFormField(
      controller: _controller,
      onTap: _controller.selectAll,
      textAlign: align,
      keyboardType: TextInputType.text,
      onChanged: onChange,
      autocorrect: false,
      minLines: minLines,
      maxLines: maxLines,
      cursorColor: theme.primaryColor,
      decoration: InputDecoration(
        labelText: "...",
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        border: InputBorder.none,
        // fillColor: Colors.white10,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        label: null,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
      ),
      style: theme.headline1.copyWith(color: Colors.white, fontSize: 14.h),
    );
  }
}
