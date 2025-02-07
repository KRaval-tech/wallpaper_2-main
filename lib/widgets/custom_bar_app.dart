// import 'package:flutter/material.dart';
// import 'package:wallpaper_2/Ads/AdmobHelper.dart';
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

import 'package:flutter/material.dart';

import '../Ads/AdmobHelper.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
