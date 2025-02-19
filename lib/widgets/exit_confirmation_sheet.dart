import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper_2/core/app_export.dart';
import 'dart:ui';

import '../Ads/native_video.dart';

class ExitConfirmationBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: ExitImageClipper(),
                child: Image.asset(
                  'assets/images/bgassets.jpg', // Replace with actual image
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                // top: 8,
                // right: 8,
                // child: IconButton(
                //   icon: Icon(Icons.close, color: Colors.white, size: 28),
                //   onPressed: () => Navigator.pop(context),
                // ),
                top: 8.h,
                right: 8.h,
                //child: SvgPicture.asset("assets/svg/close_circle.svg",height: 24.h,width: 24.h,color: Colors.white,),
                child: CustomImageView(
                  imagePath: 'assets/svg/close_circle.svg',
                  height: 24.h,
                  width: 24.h,
                  onTap: () => Navigator.pop(context),
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "Leave this app...?",
            style: TextStyle(
                fontSize: 18.fSize,
                fontWeight: FontWeight.w700,
                fontFamily: "SF Pro Display"
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Are you sure you want to leave this app?",
            style: TextStyle(
                fontSize: 18.fSize,
                color: Color(0xFF848484),
              fontFamily: "SF Pro Display",
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 46.h,
                width: 130.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2,color: Colors.transparent),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF50AAF9), Color(0xFF1972D6)],
                  ),
                ),
                // child: OutlinedButton(
                //   onPressed: () => _exitApp(context),
                //   style: OutlinedButton.styleFrom(
                //     side: BorderSide(color: Colors.blue, width: 2),
                //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                //   ),
                //   child: Text("Yes", style: TextStyle(fontSize: 18, color: Colors.blue)),
                // ),
                child: Container(
                  //margin: EdgeInsets.all(2), // To ensure border effect
                  decoration: BoxDecoration(
                    color: Colors.white, // Inner background color
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () {
                      _exitApp(context);
                    },
                    child: Center(
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          color: Color(0xFF848484),
                          fontSize: 18.fSize,
                          fontWeight: FontWeight.w700,
                          fontFamily: "SF Pro Display",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //SizedBox(width: 25),
              Container(
                height: 46.h,
                width: 201.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF50AAF9), Color(0xFF1972D6)], // Full gradient background
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                // child: ElevatedButton(
                //   onPressed: () => Navigator.pop(context),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.blue,
                //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                //   ),
                //   child: Text("No", style: TextStyle(fontSize: 18, color: Colors.white)),
                // ),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Center(child: Text("No",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.fSize,
                          fontWeight: FontWeight.w700,
                        fontFamily: "SF Pro Display",
                      )
                  )),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          //NativeVideoAdWidget(),
          Container(
            height: 250.h, // Fixed height for ad box
            child: NativeVideoAdWidget(),
          ),
          //SizedBox(height: 15),
        ],
      ),
    );
  }

  void _exitApp(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      Navigator.of(context).pop();
      Future.delayed(Duration(milliseconds: 300), () {
        SystemNavigator.pop();
      });
    } else {
      Navigator.of(context).pop();
    }
  }
}

class ExitImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    Path path = Path();
    path.lineTo(0, h * 0.5);
    path.quadraticBezierTo(
      w * 0.5,
      h + 100,
      w,
      h * 0.5,
    );
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
