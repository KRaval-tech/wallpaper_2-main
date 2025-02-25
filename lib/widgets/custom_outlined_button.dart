import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_2/core/app_export.dart';
import 'package:wallpaper_2/theme/custom_button_style.dart';
import 'package:wallpaper_2/widgets/base_button.dart';

class CustomOutlinedButton extends BaseButton{
  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  final Alignment? alignment;

  final Widget? label;

  const CustomOutlinedButton(
      {super.key,
        this.decoration,
        this.leftIcon,
        this.rightIcon,
        this.label,
        this.alignment,
        super.margin,
        super.onPressed,
        super.buttonStyle,
        super.buttonTextStyle,
        super.isDisabled,
        super.height,
        super.width,
        required super.text})
      : super(
      alignment: alignment
  );

  @override
  Widget build(BuildContext context){
    return alignment != null
        ? Align(alignment: alignment ?? Alignment.center,child: buildOutlinedButtonWidget,)
        : buildOutlinedButtonWidget;
  }

  Widget get buildOutlinedButtonWidget => Container(
    height: this.height ?? 72.h,
    width: this.width ?? double.maxFinite,
    margin: margin,
    decoration: decoration ?? CustomButtonStyles.gradientOrangeToYellowDecoration,
    child: OutlinedButton(
      style: buttonStyle,
      onPressed: isDisabled ?? false ? null : onPressed ?? (){},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leftIcon ?? const SizedBox.shrink(),
          Text(
            text,
            style: buttonTextStyle ?? theme.textTheme.titleMedium,
          ),
          rightIcon ?? const SizedBox.shrink()
        ],
      ),
    ),
  );
}