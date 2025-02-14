import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_2/screens/choose_language_screen/choose_language.dart';
import '../../core/app_export.dart';
import 'bloc/home_bloc.dart';
import 'models/home_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        HomeState(
          homeModelObj: HomeModel(),
        ),
      )..add(HomeInitialEvent()),
      child: const HomeScreen(),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  InterstitialAd? _interstitialAd;
  bool _isAdShown = false; // Track if the ad has been shown
  bool _isNavigated = false; // Ensure navigation happens only once

  @override
  void initState() {
    super.initState();
    _initializeInterstitialAd(); // Start loading the ad
  }

  Future<void> _initializeInterstitialAd() async {
    // Show loader while the ad is loading
    setState(() {
      _isAdShown = false; // Initially, the ad is not shown
    });
    await Future.delayed(const Duration(seconds: 2)); // Splash screen delay

    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Replace with your AdMob ad unit ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad; // Store the loaded ad

          if (!_isAdShown) {
            setState(() {
              _isAdShown = true; // Mark ad as shown
            });

            _interstitialAd!.show(); // Show the ad

            // Handle navigation after ad is dismissed
            _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose(); // Dispose of the ad
                _navigateToChooseLanguageScreen(); // Navigate to the next screen
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose(); // Dispose of the ad
                _navigateToChooseLanguageScreen(); // Navigate if ad fails to show
              },
            );
          }
        },
        onAdFailedToLoad: (error) {
          debugPrint('Failed to load an interstitial ad: ${error.message}');
          _navigateToChooseLanguageScreen(); // Navigate directly if ad fails to load
        },
      ),
    );
  }

  Future<void> _navigateToChooseLanguageScreen() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedLanguage = prefs.getString('language');

    if (!_isNavigated) {
      setState(() {
        _isNavigated = true; // Mark as navigated
      });

      // Navigator.pushReplacementNamed(
      //   context,
      //   AppRoutes.chooseLanguage
      // );
      if(selectedLanguage != null && selectedLanguage.isNotEmpty){
        //If language is set , go to home screen
        Navigator.pushReplacementNamed(context, AppRoutes.custombottombar);
      }else{
        // Otherwise, go to language selection screen
        Navigator.pushReplacementNamed(context, AppRoutes.chooseLanguage);
      }
      //AppRoutes.chooseLanguage;
    }
  }

  @override
  void dispose() {
    _interstitialAd?.dispose(); // Dispose of the ad when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _isAdShown
              ? CircularProgressIndicator() // Show loader while ad is loading
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 30,),
              if(!_isAdShown)
                const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}



