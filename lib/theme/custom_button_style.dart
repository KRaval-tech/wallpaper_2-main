import 'package:flutter/material.dart';
import 'package:wallpaper_2/core/app_export.dart';

class CustomButtonStyles {
  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
    backgroundColor: theme.colorScheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.h),
    ),
    elevation: 0,
    padding: EdgeInsets.zero,
  );

  static BoxDecoration get gradientBlueToBlueDecoration => BoxDecoration(
    borderRadius: BorderRadius.circular(12.h),
    gradient: LinearGradient(
      begin: const Alignment(0.5, 0),
      end: const Alignment(0.5, 0),
      colors: [appTheme.blue400, appTheme.blue700],
    ),
  );

  static BoxDecoration get gradientOrangeToYellowDecoration => BoxDecoration(
    borderRadius: BorderRadius.circular(60.h),
    border: Border.all(
      //color: theme.colorScheme.onPrimary,
      color: Colors.white,
      width: 1.h,
    ),
    boxShadow: [
      BoxShadow(
        color: const Color(0x47FEC714),//appTheme.amber50047,
        spreadRadius: 1.h,
        blurRadius: 25.h,
        offset: const Offset(0, 4),
      ),
    ],
    gradient: const LinearGradient(
      // begin: Alignment(0.87, 0),
      // end: Alignment(0.5, 0),
      begin: Alignment.topCenter,  // Gradient starts at the top
      end: Alignment.bottomCenter, // Gradient ends at the bottom
      colors: [Color(0xFFFFBC40),Color(0xFFFA7D2A),],//[appTheme.orange300,appTheme.yellow900],
    ),
  );

  static ButtonStyle get none => ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
    elevation: WidgetStateProperty.all<double>(0),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
    side: WidgetStateProperty.all<BorderSide>(const BorderSide(color: Colors.transparent)),
  );

}