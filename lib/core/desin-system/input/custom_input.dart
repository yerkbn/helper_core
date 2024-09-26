import 'package:helper_core/core/desin-system/theme/custom_theme_extension.dart';
import 'package:helper_core/core/desin-system/input/number_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNumberInput extends StatelessWidget {
  final String? Function(String? val) onSaved;
  final void Function() onClose;
  final void Function() onOpen;
  final String? Function(String? value)? customValidation;
  final String title;
  final String? intialValue;
  final int topPadding;
  const CustomNumberInput(
      {super.key,
      required this.onSaved,
      required this.onClose,
      required this.onOpen,
      this.customValidation,
      this.intialValue,
      this.title = 'Номер телефона',
      this.topPadding = 1});

  bool get isInitialValue {
    // expected format: +77003301098
    if (intialValue != null && intialValue!.length == 12) {
      return true;
    }
    return false;
  }

  String getInitialNumber() {
    return '${intialValue!.substring(0, 2)} ${intialValue!.substring(2, 5)} ${intialValue!.substring(5, 8)} ${intialValue!.substring(8, 12)}';
  }

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Padding(
        padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(topPadding),
        ),
        child: TextFormField(
          enableInteractiveSelection: false,
          onEditingComplete: onClose,
          onTap: onOpen,
          enableSuggestions: false,
          initialValue: isInitialValue ? getInitialNumber() : null,
          autocorrect: false,
          style: theme.headline3.copyWith(
            color: Colors.black,
            fontSize: 14.h,
          ),
          decoration: InputDecoration(
              hintText: '+7',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              labelText: title,
              hintStyle: theme.headline3.copyWith(
                color: Colors.black54,
                fontSize: 14.h,
              ),
              labelStyle: theme.headline3
                  .copyWith(color: Colors.black54, fontSize: 14.h)),
          validator: customValidation ??
              (String? value) {
                if (value!.isEmpty || value.length != 15) {
                  return 'Не может быть короче 11-ти цифр';
                }
                return null;
              },
          onSaved: onSaved,
          keyboardType: TextInputType.phone,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
            NumberTextInputFormatter()
          ],
        ));
  }
}

class CustomInput extends StatelessWidget {
  final String? Function(String? val) onSaved;
  final String? Function(String? val) validation;
  final void Function() onClose;
  final void Function() onOpen;
  final String initialValue;
  final String title;
  final bool isPassword;
  final int topPadding;

  const CustomInput({
    super.key,
    required this.onSaved,
    required this.onClose,
    required this.validation,
    required this.title,
    required this.onOpen,
    required this.initialValue,
    this.isPassword = false,
    this.topPadding = 1,
  });

  @override
  Widget build(BuildContext context) {
    final CustomThemeExtension theme = CustomThemeExtension.of(context);
    return Padding(
        padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(topPadding),
        ),
        child: TextFormField(
          validator: validation,
          enableInteractiveSelection: false,
          onSaved: onSaved,
          keyboardType: TextInputType.visiblePassword,
          onTap: onOpen,
          initialValue: initialValue,
          enableSuggestions: false,
          autocorrect: false,
          obscureText: isPassword,
          onEditingComplete: onClose,
          decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: title,
              labelStyle: theme.headline1
                  .copyWith(fontSize: 16.h, color: Colors.white38)),
          style: theme.headline1,
        ));
  }
}
