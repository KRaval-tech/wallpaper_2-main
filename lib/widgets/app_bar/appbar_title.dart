import 'package:flutter/material.dart';
import 'package:wallpaper_2/core/app_export.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle({Key? key,required this.text,this.onTap,this.margin}):super(key: key);

  final String text;
  final Function? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: (){
          onTap?.call();
        },
        child: Text(
          text,
          style: theme.textTheme.titleSmall!.copyWith(
            color: appTheme.gray500,
          ),
        ),
      ),
    );
  }
}
