// import 'package:flutter/material.dart';
// //import 'package:flutter/services.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wallpaper_2/core/app_export.dart';
// import 'package:wallpaper_2/screens/categories/bloc/categories_bloc.dart';
// import 'package:wallpaper_2/screens/categories/bloc/categories_event.dart';
// import 'package:wallpaper_2/screens/categoriesDetails/bloc/category_detail_bloc.dart';
// import 'package:wallpaper_2/screens/categoriesDetails/bloc/category_detail_event.dart';
// import 'package:wallpaper_2/screens/choose_language_screen/bloc/localization_bloc.dart';
// import 'package:wallpaper_2/screens/home_one_screen/bloc/home_one_bloc.dart';
// import 'package:wallpaper_2/screens/home_screen/bloc/home_bloc.dart';
// import 'package:wallpaper_2/screens/paywall_screen/bloc/pricing_bloc.dart';
// //import 'package:wallpaper_2/screens/premium_screen/bloc/pricing_bloc.dart';
// //import 'package:wallpaper_2/screens/premium_screen/premium_screen.dart';
//
// import 'Ads/admob_helper.dart';
//
// //import 'generated/l10n.dart';
//
// var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await AdMobHelper.initialization();
//   await _resetUnlockedWallpapers(); // Reset unlocked wallpapers on app start
//   runApp(const MyApp());
// }
//
// Future<void> _resetUnlockedWallpapers() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.remove('unlockedWallpapers'); // Clear unlocked wallpapers when app starts
// }
//
// class MyApp extends StatelessWidget{
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context){
//     return Sizer(
//         builder: (context,orientation,deviceType){
//           return MultiProvider(
//               providers: [
//                 BlocProvider<ThemeBloc>(
//                   create: (context) =>
//                       ThemeBloc(
//                         //ThemeState(themeType: PrefUtils().getThemeData()),
//                       ),
//                 ),
//                 // BlocProvider(
//                 // create: (_) => SettingsBloc()..add(LoadSettings()),
//                 // ),
//                 BlocProvider(
//                 create: (context) => CategoriesBloc()..add(FetchCategories()),
//                 ),
//                 BlocProvider(
//                 create: (context) => HomeOneBloc(ApiService())..add(FetchWallpapersEvent()),
//                 ),
//                 BlocProvider<HomeBloc>(
//                   create: (context) => HomeBloc(HomeState()), // Initialize HomeBloc with HomeState
//                 ),
//                 BlocProvider<LocalizationBloc>(
//                     create: (context) => LocalizationBloc()..add(LoadSavedLocalization()),
//                 ),
//                 BlocProvider(
//                   create: (context) => PricingBloc(),//..add(LoadPricingEvent()),
//                   //child: const PaywallScreen(),
//                 ),
//                 BlocProvider<CategoryDetailBloc>(
//                   create: (context) => CategoryDetailBloc(ApiService())..add(FetchCategoryWallpapers('')),
//                 ),
//               ],
//               child: BlocBuilder<ThemeBloc, ThemeState>(
//                   builder: (context, state){
//                     return MaterialApp(
//                       theme: state.themeType == ThemeType.light
//                           ? ThemeData.light()
//                           : ThemeData.dark(),
//                       title: 'wallpaper_2',
//                       builder: (context, child){
//                         return MediaQuery(data: MediaQuery.of(context).copyWith(
//                           textScaler: const TextScaler.linear(1.0),
//                         ),
//                             child: child!,
//                         );
//                       },
//                       navigatorKey: NavigatorService.navigatorKey,
//                       debugShowCheckedModeBanner: false,
//                       localizationsDelegates: const [
//                         S.delegate,
//                         GlobalMaterialLocalizations.delegate,
//                         GlobalWidgetsLocalizations.delegate,
//                         GlobalCupertinoLocalizations.delegate,
//                       ],
//                       supportedLocales: S.delegate.supportedLocales,
//                       locale: context.watch<LocalizationBloc>().state.locale,//const Locale('en'),
//                       //home: HomeScreen(),
//                       initialRoute: AppRoutes.initial,
//                       onGenerateRoute: AppRoutes.generateRoute,
//                     );
//                   }
//               ),
//           );
//         }
//     );
//   }
// }
//
//
//


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_2/core/app_export.dart';
import 'package:wallpaper_2/screens/categories/bloc/categories_bloc.dart';
import 'package:wallpaper_2/screens/categories/bloc/categories_event.dart';
import 'package:wallpaper_2/screens/categoriesDetails/bloc/category_detail_bloc.dart';
import 'package:wallpaper_2/screens/categoriesDetails/bloc/category_detail_event.dart';
import 'package:wallpaper_2/screens/choose_language_screen/bloc/localization_bloc.dart';
import 'package:wallpaper_2/screens/home_one_screen/bloc/home_one_bloc.dart';
import 'package:wallpaper_2/screens/home_screen/bloc/home_bloc.dart';
import 'package:wallpaper_2/screens/paywall_screen/bloc/pricing_bloc.dart';
import 'Ads/admob_helper.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AdMobHelper.initialization();
  await _resetUnlockedWallpapers();
  runApp(const MyApp());
}

Future<void> _resetUnlockedWallpapers() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Future.delayed(Duration(milliseconds: 200)); // Ye background me chalega
  await prefs.remove('unlockedWallpapers');
  debugPrint("Unlocked Wallpapers Reset!");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Timer? _cacheClearTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _cacheClearTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _clearCache();
    });
  }

  Future<void> _clearCache() async {
    await Future.delayed(const Duration(milliseconds: 100)); // Background me execute hoga
    imageCache.clear();
    imageCache.clearLiveImages();
    debugPrint("App Memory Optimized: Cache Cleared!");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _clearCache();
      debugPrint(" App went to Background: Cache Cleared!");
    }
  }

  @override
  void dispose() {
    imageCache.clear();
    imageCache.clearLiveImages();
    debugPrint("Cache Cleared!");
    WidgetsBinding.instance.removeObserver(this);
    _cacheClearTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            BlocProvider<ThemeBloc>(
              lazy: true,
              create: (context) => ThemeBloc(),
            ),
            BlocProvider(
              lazy: true,
              create: (context) => CategoriesBloc()..add(FetchCategories()),
            ),
            BlocProvider(
              lazy: true,
              create: (context) => HomeOneBloc(ApiService())..add(FetchWallpapersEvent()),
            ),
            BlocProvider<HomeBloc>(
              lazy: true,
              create: (context) => HomeBloc(HomeState()),
            ),
            BlocProvider<LocalizationBloc>(
              lazy: true,
              create: (context) => LocalizationBloc()..add(LoadSavedLocalization()),
            ),
            BlocProvider(
              lazy: true,
              create: (context) => PricingBloc(),
            ),
            BlocProvider<CategoryDetailBloc>(
              lazy: true,
              create: (context) => CategoryDetailBloc(ApiService())..add(FetchCategoryWallpapers('')),
            ),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                theme: state.themeType == ThemeType.light ? ThemeData.light() : ThemeData.dark(),
                title: 'wallpaper_2',
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: const TextScaler.linear(1.0),
                    ),
                    child: child!,
                  );
                },
                navigatorKey: NavigatorService.navigatorKey,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: context.watch<LocalizationBloc>().state.locale,
                initialRoute: AppRoutes.initial,
                onGenerateRoute: AppRoutes.generateRoute,
              );
            },
          ),
        );
      },
    );
  }
}
