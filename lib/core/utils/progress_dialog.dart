import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_2/core/utils/navigator_service.dart';
import 'package:wallpaper_2/core/app_export.dart';

class ProgressDialogUtils {
  static bool isProgressVisible = false;

  static void showProgressDialog({BuildContext? context, bool isCancellable = false}) async {
    if(!isProgressVisible && NavigatorService.navigatorKey.currentState?.context != null){
      showDialog(
          barrierDismissible: isCancellable,
          context: NavigatorService.navigatorKey.currentState!.overlay!.context,
          builder: (BuildContext context){
            return Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          }
      );
      isProgressVisible = true;
    }
  }

  static void hideProgressDialog(){
    if(isProgressVisible)
      Navigator.pop(
          NavigatorService.navigatorKey.currentState!.overlay!.context);
    isProgressVisible = false;
  }

}