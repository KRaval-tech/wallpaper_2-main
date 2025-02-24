// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class InterstitialAdHelper {
//   InterstitialAd? _interstitialAd;
//   bool _isAdLoaded = false;
//
//   /// Loads an interstitial ad
//   void loadAd() {
//     InterstitialAd.load(
//       adUnitId: 'ca-app-pub-3940256099942544/1033173712',
//       request: const AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (InterstitialAd ad) {
//           _interstitialAd = ad;
//           _isAdLoaded = true;
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           _interstitialAd = null;
//           _isAdLoaded = false;
//           print('Interstitial ad failed to load: $error');
//         },
//       ),
//     );
//   }
//
//   /// Shows the interstitial ad with a loader
//   void showAd(BuildContext context, VoidCallback onAdClosed) {
//     if (_isAdLoaded && _interstitialAd != null) {
//       _showLoadingDialog(context);
//
//       _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//         onAdDismissedFullScreenContent: (ad) {
//           _hideLoadingDialog(context);
//           onAdClosed(); // Execute callback after ad closes
//         },
//         onAdFailedToShowFullScreenContent: (ad, error) {
//           _hideLoadingDialog(context);
//           onAdClosed();
//         },
//       );
//
//       Future.delayed(const Duration(seconds: 1), () {
//         _hideLoadingDialog(context);
//         _interstitialAd!.show();
//       });
//
//     } else {
//       onAdClosed(); // If ad is not loaded, go back immediately
//     }
//   }
//
//   /// Show loading dialog
//   void _showLoadingDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return const Center(child: CircularProgressIndicator());
//       },
//     );
//   }
//
//   /// Hide loading dialog
//   void _hideLoadingDialog(BuildContext context) {
//     if (Navigator.canPop(context)) {
//       Navigator.pop(context);
//     }
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class InterstitialAdHelper {
//   InterstitialAd? _interstitialAd;
//   bool _isAdLoaded = false;
//   bool _isLoading = false; // 🔹 Track loading state globally
//
//   /// Loads an interstitial ad
//   void loadAd() {
//     InterstitialAd.load(
//       adUnitId: 'ca-app-pub-3940256099942544/1033173712',
//       request: const AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (InterstitialAd ad) {
//           _interstitialAd = ad;
//           _isAdLoaded = true;
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           _interstitialAd = null;
//           _isAdLoaded = false;
//           print('Interstitial ad failed to load: $error');
//         },
//       ),
//     );
//   }
//
//   /// Shows the interstitial ad with a loader
//   void showAd(BuildContext context, VoidCallback onAdClosed) {
//     if (_isAdLoaded && _interstitialAd != null) {
//       _showLoadingDialog();
//
//       _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//         onAdDismissedFullScreenContent: (ad) {
//           _isLoading = false; // Loader hatane ke liye flag update karein
//           onAdClosed(); // Execute callback after ad closes
//         },
//         onAdFailedToShowFullScreenContent: (ad, error) {
//           _isLoading = false;
//           onAdClosed();
//         },
//       );
//
//       Future.delayed(const Duration(seconds: 1), () {
//         _hideLoadingDialog(); // Loader hatao
//         _interstitialAd!.show();
//       });
//     } else {
//       onAdClosed(); // If ad is not loaded, go back immediately
//     }
//   }
//
//   /// Show loading dialog globally
//   void _showLoadingDialog() {
//     _isLoading = true;
//   }
//
//   /// Hide loading dialog
//   void _hideLoadingDialog() {
//     _isLoading = false;
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdHelper {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;
  bool _isLoading = false; // 🔹 Track loading state globally

  /// Loads an interstitial ad
  void loadAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Test Ad ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print("✅ Interstitial Ad Loaded!");
          _interstitialAd = ad;
          _isAdLoaded = true;
          },
        onAdFailedToLoad: (LoadAdError error) {
          print("❌ Interstitial Ad Failed to Load: $error");
          _interstitialAd = null;
          _isAdLoaded = false;
        },
      ),
    );
  }

  /// Shows the interstitial ad with a loader
  void showAd(BuildContext context, VoidCallback onAdClosed) {
    if (_isAdLoaded && _interstitialAd != null) {
      _showLoadingDialog();

      // ✅ Ad dispose callback set karein
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          print("👋 Ad Closed! Disposing now...");
          onAdClosed();
          _disposeAd(); // 🔥 Dispose the ad when closed
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print("❌ Ad Failed to Show: $error");
          onAdClosed();
          _disposeAd(); // 🔥 Dispose the ad on failure
        },
      );

      Future.delayed(const Duration(seconds: 1), () {
        _hideLoadingDialog(); // Loader hatao
        _interstitialAd!.show();
      });

      _isAdLoaded = false; // ✅ Ad ko show hone ke baad mark as not loaded
    } else {
      print("⚠️ Ad Not Loaded Yet!");
      onAdClosed(); // If ad is not loaded, go back immediately
    }
  }

  /// 🔥 Properly dispose the ad
  void _disposeAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _isAdLoaded = false;
  }

  /// Show loading dialog globally
  void _showLoadingDialog() {
    _isLoading = true;
  }

  /// Hide loading dialog
  void _hideLoadingDialog() {
    _isLoading = false;
  }

  /// ✅ Dispose function jab class destroy ho jaye
  void dispose() {
    _disposeAd();
  }
}
