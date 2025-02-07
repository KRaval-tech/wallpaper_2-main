import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_2/core/app_export.dart';
import 'package:wallpaper_2/screens/categories/bloc/categories_bloc.dart';
import 'package:wallpaper_2/screens/categories/bloc/categories_event.dart';
import 'package:wallpaper_2/screens/categoriesDetails/bloc/category_detail_bloc.dart';
import 'package:wallpaper_2/screens/categoriesDetails/bloc/category_detail_event.dart';
import 'package:wallpaper_2/screens/choose_language_screen/bloc/localization_bloc.dart';
import 'package:wallpaper_2/screens/home_one_screen/bloc/home_one_bloc.dart';
import 'package:wallpaper_2/screens/home_screen/bloc/home_bloc.dart';
import 'package:wallpaper_2/screens/home_screen/home_screen.dart';
import 'package:wallpaper_2/screens/paywall_screen/bloc/pricing_bloc.dart';
//import 'package:wallpaper_2/screens/premium_screen/bloc/pricing_bloc.dart';
//import 'package:wallpaper_2/screens/premium_screen/premium_screen.dart';
import 'package:wallpaper_2/screens/settings_screen/bloc/settings_bloc.dart';
import 'package:wallpaper_2/screens/settings_screen/bloc/settings_event.dart';

import 'Ads/AdmobHelper.dart';

//import 'generated/l10n.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AdMobHelper.initialization();
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Sizer(
        builder: (context,orientation,deviceType){
          return MultiProvider(
              providers: [
                BlocProvider<ThemeBloc>(
                  create: (context) =>
                      ThemeBloc(
                        //ThemeState(themeType: PrefUtils().getThemeData()),
                      ),
                ),
                BlocProvider(
                create: (_) => SettingsBloc()..add(LoadSettings()),
                ),
                BlocProvider(
                create: (context) => CategoriesBloc()..add(FetchCategories()),
                ),
                BlocProvider(
                create: (context) => HomeOneBloc(ApiService())..add(FetchWallpapersEvent()),
                ),
                BlocProvider<HomeBloc>(
                  create: (context) => HomeBloc(HomeState()), // Initialize HomeBloc with HomeState
                ),
                BlocProvider<LocalizationBloc>(
                    create: (context) => LocalizationBloc()..add(LoadSavedLocalization()),
                ),
                BlocProvider(
                  create: (context) => PricingBloc(),//..add(LoadPricingEvent()),
                  //child: const PaywallScreen(),
                ),
                BlocProvider<CategoryDetailBloc>(
                  create: (context) => CategoryDetailBloc(ApiService())..add(FetchCategoryWallpapers('')),
                ),
              ],
              child: BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state){
                    return MaterialApp(
                      theme: state.themeType == ThemeType.light
                          ? ThemeData.light()
                          : ThemeData.dark(),
                      title: 'wallpaper_2',
                      builder: (context, child){
                        return MediaQuery(data: MediaQuery.of(context).copyWith(
                          textScaler: TextScaler.linear(1.0),
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
                      locale: context.watch<LocalizationBloc>().state.locale,//const Locale('en'),
                      //home: HomeScreen(),
                      initialRoute: AppRoutes.initial,
                      onGenerateRoute: AppRoutes.generateRoute,
                    );
                  }
              ),
          );
        }
    );
  }
}

