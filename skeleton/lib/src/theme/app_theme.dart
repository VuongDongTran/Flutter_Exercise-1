import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/app_helper.dart';
import 'colors_theme.dart';

ThemeData appLightTheme(BuildContext context) => ThemeData(
      fontFamily: GoogleFonts.openSans().fontFamily,
      pageTransitionsTheme: _pageTransitions,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: Theme.of(context).textTheme.appBarTextStyle,
        selectedItemColor: AppColors.ceriseColor,
        unselectedItemColor: AppColors.neutral90,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedLabelStyle: Theme.of(context).textTheme.appBarTextStyle,
      ),
      appBarTheme: AppBarTheme(
          // color: AppColors.white,
          elevation: 0,
          centerTitle: !AppHelper.isTablet(),
          titleTextStyle: TextStyle(color: AppColors.neutral90)),
      textTheme: appTextTheme,
    );

PageTransitionsTheme get _pageTransitions => const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
      },
    );
TextTheme appTextTheme = const TextTheme(
  displayLarge: TextStyle(
    color: Color(0xFF70777E),
    fontSize: 64,
    fontWeight: FontWeight.w600,
    height: 1.28,
  ),
  displayMedium: TextStyle(
    color: Color(0xFF70777E),
    fontSize: 48,
    fontWeight: FontWeight.w600,
    height: 1.21,
  ),
  displaySmall: TextStyle(
    color: Color(0xFF70777E),
    fontSize: 36,
    fontWeight: FontWeight.w600,
    height: 1.33,
  ),
  headlineMedium: TextStyle(
    color: Color(0xFF70777E),
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.29,
  ),
  //H5
  headlineSmall: TextStyle(
    color: Color(0xFF70777E),
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.60,
  ),
  titleLarge: TextStyle(
    color: Color(0xFF70777E),
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.75,
  ),
  bodyLarge: TextStyle(
    color: Color(0xFF70777E),
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.50,
  ),
  bodyMedium: TextStyle(
    color: Color(0xFF70777E),
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.71,
  ),
  bodySmall: TextStyle(
    color: Color(0xFF70777E),
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 2,
  ),
  titleSmall: TextStyle(
    color: Color(0xFF333D47),
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 2,
  ),
);

extension CustomTextStyle on TextTheme {
  TextStyle get appBarTextStyle => const TextStyle(
        color: Color(0xFF475059),
        fontSize: 10,
        fontWeight: FontWeight.w400,
        height: 2.40,
      );
  TextStyle get buttonStatus => const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );
}
