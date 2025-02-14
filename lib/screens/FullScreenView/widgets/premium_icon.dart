// Separate Widget for Premium Icon
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class PremiumIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      left: 294,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFBC40), Color(0xFFFA7D2A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(52),
        ),
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: CustomImageView(
            imagePath: ImageConstant.imgNavPremium1,
            height: 24,
            width: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}