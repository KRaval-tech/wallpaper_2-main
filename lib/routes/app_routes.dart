// lib/routes/app_routes.dart

import 'package:flutter/material.dart';
import 'package:wallpaper_2/screens/home_one_screen/home_one_screen.dart';
import 'package:wallpaper_2/screens/categories/categories_screen.dart';
//import 'package:wallpaper_2/screens/premium_screen/premium_screen.dart';
import 'package:wallpaper_2/screens/settings_screen/settings_screen.dart';
import 'package:wallpaper_2/screens/choose_language_screen/choose_language.dart';
import 'package:wallpaper_2/widgets/custom_bar_app.dart';
import 'package:wallpaper_2/widgets/custom_bottom_bar.dart';

import '../screens/home_screen/home_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String custombottombar = '/bottombar';
  static const String home = '/home';
  static const String categories = '/categories';
  static const String premium = '/premium';
  static const String setting = '/settings';
  static const String chooseLanguage = '/choose-language';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (_)=> HomeScreen.builder(_));
      case custombottombar:
        return MaterialPageRoute(builder: (_) => CustomBottomBarApp());
      case home:
        return MaterialPageRoute(builder: (_) => HomeOneScreen.builder(_));
      case categories:
        return MaterialPageRoute(builder: (_) => CategoriesPage());
      case premium:
        //return MaterialPageRoute(builder: (_) => PaywallScreen());
      case setting:
        return MaterialPageRoute(builder: (_) => SettingsPage.builder(_));
      case chooseLanguage:
        return MaterialPageRoute(builder: (_) => ChooseLanguageScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen.builder(_)); // Fallback to home
    }
  }
}