import 'package:flutter/material.dart';
import 'package:wallpaper_2/core/app_export.dart';
import 'package:wallpaper_2/theme/custom_button_style.dart';
import 'package:wallpaper_2/widgets/custom_outlined_button.dart';

import '../../generated/l10n.dart';
import '../../screens/paywall_screen/paywall_screen.dart';

class AppbarTrailingButton extends StatelessWidget {
  final Function? onTap;

  final EdgeInsetsGeometry? margin;

  const AppbarTrailingButton(
      {super.key,this.onTap,
        this.margin,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child:
      // GestureDetector(
      //   onTap: (){
      //     onTap?.call();
      //     // Navigator.push(
      //     //   context,
      //     //   MaterialPageRoute(builder: (context) => PaywallScreen(
      //     //     //onTrialStarted: _removeAds,
      //     //   )),
      //     // );
      //   },
         CustomOutlinedButton(
          height: 30.h,
          width: 86.h,
          text: S.current.lbl_get_a_pro,
          leftIcon: Container(
            margin: EdgeInsets.only(right: 6.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgNavPremium,
              height: 12.h,
              width: 12.h,
              fit: BoxFit.contain,
            ),
          ),
          buttonStyle: CustomButtonStyles.none,
          decoration: CustomButtonStyles.gradientOrangeToYellowDecoration,
          buttonTextStyle: CustomTextStyles.labelLargeOnPrimary,
           onPressed: () {
             print("AppbarTrailingButton tapped!");
             onTap?.call(); // Call the onTap function passed from the parent
           },
        ),

    );
  }
}


