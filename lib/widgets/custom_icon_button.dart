import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_2/core/app_export.dart';

extension IconButtonStyleHelper on CustomIconButton{
  static BoxDecoration get outlineBlackTL30 => BoxDecoration(
    color: appTheme.cyan700,
    borderRadius: BorderRadius.circular(30.h),
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withOpacity(0.15),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: const Offset(0, 4),
      )
    ],
  );

  static BoxDecoration get outlineBlackTL301 => BoxDecoration(
    color: appTheme.greenA700,
    borderRadius: BorderRadius.circular(30.h),
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withOpacity(0.15),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: const Offset(0, 4),
      )
    ],
  );

  static BoxDecoration get outlineBlackTL302 => BoxDecoration(
    color: appTheme.blue500,
    borderRadius: BorderRadius.circular(30.h),
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withOpacity(0.15),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: const Offset(0, 4),
      )
    ],
  );

  static BoxDecoration get outlineBlackTL303 => BoxDecoration(
    color: appTheme.pinkA200,
    borderRadius: BorderRadius.circular(30.h),
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withOpacity(0.15),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: const Offset(0, 4),
      )
    ],
  );

  static BoxDecoration get gradientOrangeToYellow => BoxDecoration(
    //color: appTheme.cyan700,
    borderRadius: BorderRadius.circular(12.h),
    boxShadow: [
      BoxShadow(
        //color: appTheme.black900.withOpacity(0.15),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        //offset: Offset(0, 4),
      )
    ],
    gradient: LinearGradient(
      colors: [appTheme.orange300,appTheme.yellow900],
      begin: const Alignment(0.87, 0),
      end: const Alignment(0.5, 0),
    ),
  );

  static BoxDecoration get none => const BoxDecoration();
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key,
    this.alignment,
    this.height,
    this.width,
    this.decoration,
    this.padding,
    this.onTap,
    this.child});


  final Alignment? alignment;
  final double? height;
  final double? width;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
        alignment: alignment ?? Alignment.center, child: iconButtonWidget)
        : iconButtonWidget;
  }

  Widget get iconButtonWidget =>
      SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: DecoratedBox(decoration: decoration ??
            BoxDecoration(
              color: appTheme.deepOrange400,
              borderRadius: BorderRadius.circular(30.h),
              boxShadow: [
                BoxShadow(
                  color: appTheme.black900.withOpacity(0.15),
                  spreadRadius: 2.h,
                  blurRadius: 2.h,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          child: IconButton(onPressed: onTap,
            icon: child ?? Container(),
            padding: padding ?? EdgeInsets.zero,),
        ),
      );
}