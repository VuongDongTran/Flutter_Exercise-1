import 'package:flutter/material.dart';

//http://mcg.mbitson.com/#!?apptheme=%239f508a

class AppColors {
  static const MaterialColor primayRed =
      MaterialColor(primaryValue, <int, Color>{
    95: Color(0xFFFDF3F6),
    70: Color(0xFFF2B8C7),
    0: Color(primaryValue),
    50: Color(0xFFE988A2),
    15: Color(0xFFB30E3B),
    25: Color(0xFF9E0D34),
    35: Color(0xFF890B2D),
  });
  static const int primaryValue = 0xFFD31145;

  static Color get background95 => const Color(0xFFF5F5F6);
  static Color get background97 => const Color(0xFFFAFAFA);
  static Color get background100 => const Color(0xFFFFFFFF);
  static Color get backgroundBlue => const Color(0xFFF9FAFE);

  static Color get neutral90 => const Color(0xFF475059);
  static Color get neutral70 => const Color(0xFF70777E);
  static Color get neutral50 => const Color(0xFF999EA3);
  static Color get neutral30 => const Color(0xFFC2C5C8);
  static Color get neutral15 => const Color(0xFFE0E2E3);
  static Color get neutral10 => const Color(0xFFEBECED);
  static Color get neutral5 => const Color(0xFFF5F5F6);
  static Color get neutral2 => const Color(0xFFFAFAFA);

  static const primaryColor = Color(0xFFD31145);
  static const ceriseColor = Color(0xFF860063);
  static const black = Color(0xFF333333);
  static const white = Color(0xFFFFFFFF);
  static const deepPurple = Color(0xFF5E224E);
  static const transparent = Colors.transparent;

  static const lightPurple = Color(0xff9F508A);
  static const charcoal = Color(0xff333D47);
  static const complete = Color(0xff3DA758);
  static const warning = Color(0xffF0B345);
  static const blue = Color(0xff0F53BA);
  static const purple = Color(0xff6554C0);
  static const purpleDark15 = Color(0xff5647A3);
  static const purpleDark25 = Color(0xff4C3F90);
  static const yellowDark15 = Color(0xffCC983B);
  static const yellowDark25 = Color(0xffB48634);
  static const yellowDark35 = Color(0xff9C742D);
  static const orange = Color(0xffE99043);
  static const organgeDark15 = Color(0xffFF754D);
  static const organgeDark35 = Color(0xffCC5F41);
  static const inProgress = Color(0xff0F53BA);
  static const error = Color(0xffBA0361);
  static const red = Color(0xffB30E3B);
}

extension ColorExtension on Color {
  Color copyWith({required Color color}) => color;
}
