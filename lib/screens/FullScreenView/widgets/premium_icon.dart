import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class PremiumIcon extends StatelessWidget {
  final bool isPremium;

  const PremiumIcon({
    Key? key,
    required this.isPremium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isPremium) return SizedBox.shrink();

    return Positioned(
      top: 70.h,
      left: 294.h,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFBC40),
              Color(0xFFFA7D2A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(52.h),
        ),
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: CustomImageView(
            imagePath: ImageConstant.imgNavPremium1,
            height: 24.h,
            width: 24.h,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}