// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:wallpaper_2/core/app_export.dart';
//
// import '../Ads/native_video.dart';
//
//
// class RatingBottomSheet extends StatefulWidget {
//   final VoidCallback onRatingDone;
//   final VoidCallback onPlayStoreOpened;
//   final VoidCallback onNoPressed;  // <-- New parameter added
//
//
//   const RatingBottomSheet({super.key, required this.onRatingDone, required this.onPlayStoreOpened,required this.onNoPressed});
//
//   @override
//   State<RatingBottomSheet> createState() => _RatingBottomSheetState();
// }
//
// class _RatingBottomSheetState extends State<RatingBottomSheet> {
//   //int selectedRating = 0;
//
//   Future<void> _openPlayStore() async {
//     const url = "https://play.google.com/store/apps";
//     if (await canLaunch(url)) {
//       await launch(url);
//     }
//     widget.onPlayStoreOpened();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       //padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(22.h)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Align(
//             alignment: Alignment.topRight,
//             child: Padding(
//               padding: EdgeInsets.only(top: 8.h,right: 8.h),
//                // child: SvgPicture.asset("assets/svg/close_circle.svg",height: 24.h,width: 24.h,))
//               child: CustomImageView(
//                 imagePath: "assets/svg/close_circle.svg",
//                 height: 24.h,
//                 width: 24.h,
//                 onTap: () => Navigator.pop(context),
//               ),
//             // IconButton(
//             //   icon: Icon(Icons.close),
//             //   onPressed: () => Navigator.pop(context),
//             // ),
//           ),
//           ),
//           // Image.asset("assets/images/rate_us.jpg"),
//           // //SvgPicture.asset("assets/rate_us.svg"),
//           // Text("Rating App...?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               Image.asset("assets/images/rate_us.jpg"),
//               // //SvgPicture.asset("assets/rate_us.svg"),
//               Positioned(
//                 bottom: 8.h,
//                   child: Text("Rating App...?",
//                      // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
//                     style: theme.textTheme.titleLarge,
//                   ),
//               ),
//             ],
//           ),
//           //SizedBox(height: 8.h),
//           Text("Do you like our app?",
//               style: TextStyle(
//                   fontSize: 18.fSize,
//                   color: Color(0xFF848484),
//                 fontWeight: FontWeight.w500,
//                 fontFamily: "SF Pro Display"
//               ),
//           ),
//           SizedBox(height: 16.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             // children: List.generate(
//             //   5,
//             //       (index) => Icon(
//             //         Icons.star,
//             //       // color: index < selectedRating ? Colors.orange : Colors.grey,
//             //       color: Colors.orange,
//             //       size: 32,
//             //   ),
//             // ),
//             children: List.generate(
//               5,
//                   (index) => Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.h),
//                 child: SvgPicture.asset(
//                   "assets/svg/star.svg",
//                   height: 36.h,
//                   width: 36.h,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 16.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 height: 46.h,
//                 width: 130.h,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.h),
//                   border: Border.all(width: 2, color: Colors.transparent), // Set transparent border
//                   gradient: const LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [Color(0xFF50AAF9), Color(0xFF1972D6)], // Gradient Border Colors
//                   ),
//                 ),
//                 child: Container(
//                   //margin: EdgeInsets.all(2), // To ensure border effect
//                   decoration: BoxDecoration(
//                     color: Colors.white, // Inner background color
//                     borderRadius: BorderRadius.circular(8.h),
//                   ),
//                   child: InkWell(
//                     onTap: () {
//                       // widget.onRatingDone();
//                       // Navigator.pop(context);
//                       Navigator.pop(context);
//                       widget.onNoPressed();  // <-- Call the new callback
//                     },
//                     child: Center(
//                       child: Text(
//                         "No",
//                         style: TextStyle(
//                           color: Color(0xFF848484),
//                           fontSize: 18.fSize,
//                           fontWeight: FontWeight.w700,
//                           fontFamily: "SF Pro Display",
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // Second Container with Full Gradient Background
//               Container(
//                 height: 46.h,
//                 width: 201.h,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.h),
//                   gradient: const LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [Color(0xFF50AAF9), Color(0xFF1972D6)], // Full gradient background
//                   ),
//                 ),
//                 child: InkWell(
//                   onTap: () {
//                     widget.onRatingDone();
//                     _openPlayStore();
//                     Navigator.pop(context);
//                   },
//                   child: Center(
//                     child: Text(
//                       "Yes",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18.fSize,
//                         fontWeight: FontWeight.w700,
//                         fontFamily: "SF Pro Display",
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8.h),
//           //NativeVideoAdWidget(),
//           // Ad box that shows loading text while ad is loading
//           Container(
//             height: 250.h, // Fixed height for ad box
//             child: NativeVideoAdWidget(),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rate_my_app/rate_my_app.dart'; // Import the rate_my_app package
import 'package:wallpaper_2/core/app_export.dart';

import '../Ads/native_video.dart';

class RatingBottomSheet extends StatefulWidget {
  final VoidCallback onRatingDone;
  final VoidCallback onPlayStoreOpened;
  final VoidCallback onNoPressed;

  const RatingBottomSheet({
    super.key,
    required this.onRatingDone,
    required this.onPlayStoreOpened,
    required this.onNoPressed,
  });

  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  // Initialize rate_my_app instance
  final RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rate_my_app_',
    minDays: 0,
    minLaunches: 0,
    remindDays: 7,
    remindLaunches: 10,
    googlePlayIdentifier: 'com.wallpaper.wallpaper_2',  // Replace with your app's package name
  );

  @override
  void initState() {
    super.initState();
    _initializeRateMyApp();
  }

  Future<void> _initializeRateMyApp() async {
    await _rateMyApp.init();
  }

  // Method to open the Play Store and launch the rate dialog
  Future<void> _openPlayStore() async {
    const url = "https://play.google.com/store/apps";
    if (await canLaunch(url)) {
      await launch(url);
    }
    widget.onPlayStoreOpened();
  }

  //Method to open the play store and launch the rate dialog
  Future<void> _rateApp() async {
    if (await _rateMyApp.shouldOpenDialog) {
      _rateMyApp.showRateDialog(context,
      title: "Rate our app",
        message: 'If you like our app, please take a moment to rate it.',
        rateButton: 'Rate now',
        laterButton: "Later",
        noButton: "No, thanks",
      );
      widget.onRatingDone();
    }else {
      // If dialog shouldn't open, just call the callback
      widget.onRatingDone();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.h)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: 8.h, right: 8.h),
              child: CustomImageView(
                imagePath: "assets/svg/close_circle.svg",
                height: 24.h,
                width: 24.h,
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset("assets/images/rate_us.jpg"),
              Positioned(
                bottom: 8.h,
                child: Text(
                  "Rating App...?",
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ],
          ),
          Text(
            "Do you like our app?",
            style: TextStyle(
              fontSize: 18.fSize,
              color: Color(0xFF848484),
              fontWeight: FontWeight.w500,
              fontFamily: "SF Pro Display",
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
                  (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: SvgPicture.asset(
                  "assets/svg/star.svg",
                  height: 36.h,
                  width: 36.h,
                ),
              ),
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
                  borderRadius: BorderRadius.circular(10.h),
                  border: Border.all(width: 2, color: Colors.transparent),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF50AAF9), Color(0xFF1972D6)],
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.h),
                  ),
                  child: InkWell(
                    onTap: () {
                      widget.onNoPressed();
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        "No",
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
              Container(
                height: 46.h,
                width: 201.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.h),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF50AAF9), Color(0xFF1972D6)],
                  ),
                ),
                child: InkWell(
                  onTap: _rateApp,  // Trigger the rate dialog
                  child: Center(
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.fSize,
                        fontWeight: FontWeight.w700,
                        fontFamily: "SF Pro Display",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            height: 250.h,
            child: NativeVideoAdWidget(),
          ),
        ],
      ),
    );
  }
}
