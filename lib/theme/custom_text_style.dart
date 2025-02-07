// TODO Implement this library.
import 'package:wallpaper_2/core/app_export.dart';
import 'package:flutter/material.dart';

extension on TextStyle {
  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }
}


class CustomTextStyles{
  static TextStyle get labelLargeOnPrimary =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get labelLargeRobotoBlue500 =>
      theme.textTheme.labelLarge!.roboto.copyWith(
        color: appTheme.blue500,
      );

  static TextStyle get labelLargeRobotoSecondaryContainer =>
      theme.textTheme.labelLarge!.roboto.copyWith(
        color: theme.colorScheme.secondaryContainer,
      );

  static TextStyle get titleMediumBlack900 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get titleMediumBold => theme.textTheme.titleMedium!.copyWith(
    fontWeight: FontWeight.w700,
  );

}


// import 'package:flutter/material.dart';
// import 'package:wallpaper_2/core/app_export.dart';
//
// extension on TextStyle {
//   TextStyle get roboto {
//     return copyWith(fontFamily: 'Roboto');
//   }
//
//   TextStyle get sfProDisplay {
//     return copyWith(fontFamily: 'SFProDisplay');
//   }
// }
//
// class CustomTextStyles {
//   //static ThemeData get theme => ThemeData.light(); // Replace with your app's theme
//   //static ColorScheme get appTheme => ThemeData.light().colorScheme;
//
//   static TextStyle get labelLargeOnPrimary =>
//       theme.textTheme.labelLarge!.copyWith(
//         color: theme.colorScheme.onPrimary,
//         fontWeight: FontWeight.w700,
//         fontFamily: 'SFProDisplay',
//       );
//
//   static TextStyle get labelLargeRobotoBlue500 =>
//       theme.textTheme.labelLarge!.roboto.copyWith(
//         color: appTheme.blue500, // Changed to use appTheme.primary
//       );
//
//   static TextStyle get labelLargeRobotoSecondaryContainer =>
//       theme.textTheme.labelLarge!.roboto.copyWith(
//         color: theme.colorScheme.secondaryContainer,
//       );
//
//   static TextStyle get labelLargeSFProSecondaryContainer =>
//       theme.textTheme.labelLarge!.sfProDisplay.copyWith(
//         color: theme.colorScheme.secondaryContainer,
//       );
//
//   static TextStyle get titleMediumBlack900 =>
//       theme.textTheme.titleMedium!.copyWith(
//         color: appTheme.black900, // Changed to use appTheme.primaryVariant
//         fontWeight: FontWeight.w700,
//         fontFamily: 'SFProDisplay',
//       );
//
//   static TextStyle get titleMediumBold =>
//       theme.textTheme.titleMedium!.copyWith(
//         fontWeight: FontWeight.w700,
//         fontFamily: 'SFProDisplay',
//       );
//
//   static TextStyle get titleMediumLight =>
//       theme.textTheme.titleMedium!.copyWith(
//         fontWeight: FontWeight.w300,
//         fontFamily: 'SFProDisplay',
//       );
// }
