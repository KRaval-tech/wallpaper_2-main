import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class AppbarTrailingImage extends StatelessWidget {
  const AppbarTrailingImage({super.key, this.height, this.width, this.imagePath, this.onTap, this.margin});

  final double? height;
  final double? width;
  final String? imagePath;
  final Function? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: (){
          onTap?.call();
        },
        child: CustomImageView(
          imagePath: imagePath!,
          height: height ?? 30.h,
          width: width ?? 30.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
