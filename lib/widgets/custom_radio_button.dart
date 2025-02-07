import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_2/core/app_export.dart';

extension RadioStyleHelper on CustomRadioButton {
  static BoxDecoration get outlineGray => BoxDecoration(
    borderRadius: BorderRadius.circular(8.h),
    border: Border.all(
      color: appTheme.gray400,
      width: 1.h,
    ),
  );

  static BoxDecoration get fillLightBlueF => BoxDecoration(
    color: appTheme.lightBlue1004f,
    borderRadius: BorderRadius.circular(8.h),
  );
}

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    this.decoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    this.groupValue,
    required this.onChange,
    this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.overflow,
    this.textAlign,
    this.gradient,
    this.backgroundColor,
    this.isExpandedText = false,
    this.value,
    this.title,
  });

  final BoxDecoration? decoration;
  final Alignment? alignment;
  final bool? isRightCheck;
  final double? iconSize;
  final String? value;
  final String? groupValue;
  final Function(String) onChange;
  final String? text;  // Language code or title text
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Gradient? gradient;
  final Color? backgroundColor;
  final bool isExpandedText;
  final String? title;  // This is for the language name displayed next to the radio button

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment ?? Alignment.center, child: buildRadioButtonWidget)
        : buildRadioButtonWidget;
  }

  bool get isGradient => gradient != null;
  BoxDecoration get gradientDecoration => BoxDecoration(gradient: gradient);

  Widget get buildRadioButtonWidget => GestureDetector(
    onTap: () {
      onChange(value!);
    },
    child: Container(
      decoration: decoration,
      width: width,
      padding: padding,
      child: (isRightCheck ?? false)
          ? rightSideRadioButton
          : leftSideRadioButton,
    ),
  );

  Widget get leftSideRadioButton => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(child: radioButtonWidget),
      SizedBox(
        width: text != null && text!.isEmpty ? 8 : 0,
      ),
      Expanded(flex: 3,child: isExpandedText ? Expanded(child: textWidget) : textWidget),
    ],
  );

  Widget get rightSideRadioButton => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      isExpandedText ? Expanded(child: textWidget) : textWidget,
      SizedBox(
        width: text != null && text!.isNotEmpty ? 8 : 0,
      ),
      radioButtonWidget,
    ],
  );

  Widget get textWidget => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          title ?? "",  // This will display the language name next to the radio button
          style: textStyle ?? theme.textTheme.bodyLarge,
        ),
      ),
      if (text != null && text!.isNotEmpty)
        Expanded(
          child: Text(
            text!,  // Additional text can be shown if available
            textAlign: textAlign ?? TextAlign.start,
            overflow: overflow,
            style: textStyle ?? theme.textTheme.bodyLarge,
          ),
        ),
    ],
  );

  Widget get radioButtonWidget => SizedBox(
    height: iconSize,
    width: iconSize,
    child: Radio(
      visualDensity: VisualDensity(vertical: -4, horizontal: -4),
      value: value ?? "",
      groupValue: groupValue,
      onChanged: (value) {
        onChange(value!);
      },
    ),
  );

  BoxDecoration get radioButtonDecoration =>
      BoxDecoration(color: backgroundColor);
}
