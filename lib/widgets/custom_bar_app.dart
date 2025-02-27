// import 'package:flutter/material.dart';
// import 'package:wallpaper_2/Ads/admob_helper.dart';
// import 'package:wallpaper_2/Ads/banner_ad.dart';
// import 'package:wallpaper_2/screens/categories/categories_screen.dart';
// import 'package:wallpaper_2/screens/home_one_screen/home_one_screen.dart';
// //import 'package:wallpaper_2/screens/premium_screen/premium_screen.dart';
// import 'package:wallpaper_2/screens/settings_screen/settings_screen.dart';
//
// import '../screens/paywall_screen/paywall_screen.dart';
// import 'custom_bottom_bar.dart';
//
// class CustomBottomBarApp extends StatefulWidget {
//   const CustomBottomBarApp({super.key});
//
//   @override
//   State<CustomBottomBarApp> createState() => _CustomBottomBarAppState();
// }
//
// class _CustomBottomBarAppState extends State<CustomBottomBarApp> {
//
//   BottomBarEnum _selectedTab = BottomBarEnum.Home;
//
//   final Map<BottomBarEnum, Widget> _pages = {
//     BottomBarEnum.Home: const HomeOneScreen(),//DefaultWidget(message: "Home Page"),
//     BottomBarEnum.Categories: CategoriesPage(),//CategoryScreen(), // Your Categories Page,
//     BottomBarEnum.Premium: PaywallScreen(),
//     BottomBarEnum.Settings: SettingsPage(),
//   };
//
//   void _onTabChanged(BottomBarEnum selectedTab) {
//     setState(() {
//       _selectedTab = selectedTab;
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool hideBottomBar = _selectedTab == BottomBarEnum.Premium;
//     return Scaffold(
//       // body: _pages[_selectedTab],
//       // bottomNavigationBar: hideBottomBar
//       //     ? null
//       //     :CustomBottomBar(
//       //   onChanged: _onTabChanged,
//       //   // selectedIndex: BottomBarEnum.values.indexOf(_selectedTab),
//       // ),
//       body: Column(
//         children: [
//           Expanded(child: _pages[_selectedTab] ?? Container()),
//           if (!hideBottomBar) AdMobHelper.getBannerAd(),
//           if(!hideBottomBar) CustomBottomBar(
//             onChanged: _onTabChanged,
//           )
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_2/core/app_export.dart';
import 'package:wallpaper_2/widgets/exit_confirmation_sheet.dart';
import 'package:wallpaper_2/widgets/rating_bottom_sheet.dart';

import '../Ads/admob_helper.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/home_one_screen/home_one_screen.dart';
import '../screens/paywall_screen/paywall_screen.dart';
import '../screens/settings_screen/settings_screen.dart';
import 'custom_bottom_bar.dart';

class CustomBottomBarApp extends StatefulWidget {
  const CustomBottomBarApp({super.key});

  @override
  State<CustomBottomBarApp> createState() => _CustomBottomBarAppState();
}

class _CustomBottomBarAppState extends State<CustomBottomBarApp> {
  BottomBarEnum _selectedTab = BottomBarEnum.Home;
  bool hasRated = false;
  bool shouldShowExitSheet = false;

  // Use Widget Function(BuildContext) for pages
  final Map<BottomBarEnum, Widget Function(BuildContext)> _pages = {
    BottomBarEnum.Home: (context) => const HomeOneScreen(),
    BottomBarEnum.Categories: (context) => CategoriesPage(),
    BottomBarEnum.Settings: (context) => SettingsPage(),
  };

  void _onTabChanged(BottomBarEnum selectedTab) {
    setState(() {
      _selectedTab = selectedTab;
      if (_selectedTab == BottomBarEnum.Premium) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaywallScreen(fromBottomBar: true), // Pass the flag
          ),
        ).then((_) {
          // Reset tab to Home when returning from PaywallScreen
          setState(() {
            _selectedTab = BottomBarEnum.Home;
          });
        });
      }
    });
  }

  ///IMPORTANT NOTE:

  // Future<bool> _onBackPressed() async {
  //   bool shouldExit = await showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.white,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               "Are you sure you want to exit?",
  //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //             ),
  //             SizedBox(height: 16),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 ElevatedButton(
  //                   onPressed: () => Navigator.pop(context, false), // Stay in app
  //                   child: Text("No"),
  //                 ),
  //                 ElevatedButton(
  //                   onPressed: () => Navigator.pop(context, true), // Confirm exit
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: Colors.red,
  //                   ),
  //                   child: Text("Yes"),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   ) ??
  //       false;
  //
  //   if (shouldExit) {
  //     if (Platform.isAndroid) {
  //       SystemNavigator.pop(); // Close app on Android
  //     } else if (Platform.isIOS) {
  //       exit(0); // Force close app on iOS (not recommended by Apple)
  //     }
  //   }
  //   return false; // Prevent default back navigation
  // }
  //

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(!hasRated){
          showRatingBottomSheet(context);
          return false; // Prevent default back navigation
        }else if(shouldShowExitSheet){
          showExitConfirmationBottomSheet(context);
          return false; // Prevent default back navigation
        }
        return true;
      },
      child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: _selectedTab != BottomBarEnum.Premium
                    ? _pages[_selectedTab]?.call(context) ?? Container()
                    : Container(), // Avoid rendering PaywallScreen directly
              ),
              if (_selectedTab != BottomBarEnum.Premium) AdMobHelper.getBannerAd(),
              if (_selectedTab != BottomBarEnum.Premium)
                CustomBottomBar(
                  onChanged: _onTabChanged,
                ),
            ],
          ),
      ),
    );
  }


  void showRatingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.h)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: RatingBottomSheet(
            onRatingDone: () {
              setState(() {
                hasRated = true;
                shouldShowExitSheet = true;
              });
            },
            onPlayStoreOpened: () {
              setState(() {
                shouldShowExitSheet = true;
              });
            },
          ),
        );
      },
    );
  }

  void showExitConfirmationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.h)),
      ),
      builder: (context) {
        return SingleChildScrollView(child: ExitConfirmationBottomSheet());
      },
    );
  }


}

