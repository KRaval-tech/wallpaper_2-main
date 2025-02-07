import 'package:flutter/material.dart';
import 'package:wallpaper_2/core/app_export.dart';
class AppDecoration{
  static BoxDecoration get fillOnPrimary => BoxDecoration(
    color: theme.colorScheme.onPrimary,
  );

  static BoxDecoration get lightThemeBackground => BoxDecoration(
    color: appTheme.whiteA700,
  );

  static BoxDecoration get lightThemePrimarySurface => BoxDecoration(
    color: appTheme.gray100,
  );

  static BoxDecoration get outlineBlack => BoxDecoration(
    color: theme.colorScheme.onPrimary,
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withOpacity(0.15),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration get outlineGray => BoxDecoration(
      color: theme.colorScheme.onPrimary,
      border: Border.all(
        color: appTheme.gray30002,
        width: 1.h,
      )
  );
}

class BorderRadiusStyle {
  static BorderRadius get roundedBorder14 => BorderRadius.circular(14.h);
  static BorderRadius get roundedBorder5 => BorderRadius.circular(5.h);
}