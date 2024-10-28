import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color primaryColor; // primary color of app and used to make accent
  final Color secondaryColor; // color to make secondary accent
  final Color disabledColor; // color to make disabled

  final Color backgroundColor1; // darkest background color
  final Color backgroundColor2;
  final Color backgroundColor3;
  final Color backgroundColor4; // lightest background color

  final Color textColor1; // most active text color
  final Color textColor2; // disabled color

  CustomThemeExtension({
    required this.primaryColor,
    required this.secondaryColor,
    required this.disabledColor,
    required this.backgroundColor1,
    required this.backgroundColor2,
    required this.backgroundColor3,
    required this.backgroundColor4,
    required this.textColor1,
    required this.textColor2,
  });

  factory CustomThemeExtension.of(BuildContext context) {
    return Theme.of(context).extension<CustomThemeExtension>() ??
        CustomThemeExtension.dark();
  }

  factory CustomThemeExtension.light() => CustomThemeExtension(
        primaryColor: const Color(0xFF4531FA),
        secondaryColor: const Color(0xFF76AD8D),
        backgroundColor1: const Color(0xFFFFFFFF),
        backgroundColor2: const Color(0xFFF8F8F8),
        backgroundColor3: const Color(0xFFF0F0F0),
        backgroundColor4: const Color(0xFF373737),
        textColor1: const Color(0xFF373737),
        textColor2: const Color(0xFF929292),
        disabledColor: const Color(0xFF8E8E93),
      );

  factory CustomThemeExtension.dark() => CustomThemeExtension(
        primaryColor: const Color(0xFFF2C81D4),
        secondaryColor: const Color(0xFF76AD8D),
        backgroundColor1: const Color(0xFF000000),
        backgroundColor2: const Color(0xFF161616),
        backgroundColor3: const Color(0xFF1F1F1F),
        backgroundColor4: const Color(0xFF29292D),
        textColor1: const Color(0xFFFFFFFF),
        textColor2: const Color(0xFF8E8E93),
        disabledColor: const Color(0xFF8E8E93),
      );

  static ThemeData get darkThemeData =>
      getThemeData(extension: CustomThemeExtension.dark());

  static ThemeData get lightThemeData =>
      getThemeData(extension: CustomThemeExtension.light());

  static ThemeData getThemeData({required CustomThemeExtension extension}) {
    return ThemeData(
      // backgroundColor: extension.backgroundColor1,
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: Colors.black),
      ),
      appBarTheme: AppBarTheme(color: extension.backgroundColor2),
      scaffoldBackgroundColor: extension.backgroundColor1,
      primaryColor: extension.primaryColor,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: Colors.black),
      extensions: [
        extension,
      ],
    );
  }

  TextStyle get headline1 => TextStyle(
        // 700
        color: textColor1,
        fontSize: 16.h,
        fontWeight: FontWeight.w400,
        fontFamily: "manrope_bold",
      );

  TextStyle get headline2 => TextStyle(
        // 700
        color: textColor1,
        fontSize: 14.h,
        fontWeight: FontWeight.w400,
        fontFamily: "manrope_medium",
      );

  TextStyle get headline3 => TextStyle(
        // 600
        color: textColor1,
        fontSize: 12.h,
        fontWeight: FontWeight.w400,
        fontFamily: "manrope_medium",
      );

  TextStyle get headline4 => TextStyle(
        //500
        color: textColor2,
        fontSize: 10.h,
        fontWeight: FontWeight.w400,
        fontFamily: "manrope_regular",
      );

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor1,
    Color? backgroundColor2,
    Color? backgroundColor3,
    Color? backgroundColor4,
    Color? textColor1,
    Color? textColor2,
    Color? gameBackgroundColor,
    Color? gameFocusColor,
    Color? gameButtonColor,
  }) {
    return CustomThemeExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor1: backgroundColor1 ?? this.backgroundColor1,
      backgroundColor2: backgroundColor2 ?? this.backgroundColor2,
      backgroundColor3: backgroundColor3 ?? this.backgroundColor3,
      backgroundColor4: backgroundColor4 ?? this.backgroundColor4,
      textColor1: textColor1 ?? this.textColor1,
      textColor2: textColor2 ?? this.textColor2,
      disabledColor: disabledColor,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
    ThemeExtension<CustomThemeExtension>? other,
    double t,
  ) {
    if (other is! CustomThemeExtension) {
      return this;
    }
    return CustomThemeExtension(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      backgroundColor1:
          Color.lerp(backgroundColor1, other.backgroundColor1, t)!,
      backgroundColor2:
          Color.lerp(backgroundColor2, other.backgroundColor2, t)!,
      backgroundColor3:
          Color.lerp(backgroundColor3, other.backgroundColor3, t)!,
      backgroundColor4:
          Color.lerp(backgroundColor4, other.backgroundColor4, t)!,
      textColor1: Color.lerp(textColor1, other.textColor1, t)!,
      textColor2: Color.lerp(textColor2, other.textColor2, t)!,
      disabledColor: disabledColor,
    );
  }
}
