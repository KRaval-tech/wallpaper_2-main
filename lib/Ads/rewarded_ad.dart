// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class RewardedAdHelper {
//   static RewardedAd? _rewardedAd;
//   static bool _isScreenActive = true; // Flag to track screen activity
//
//   static void showRewardedAd({
//     required BuildContext context,
//     required VoidCallback onRewardEarned,
//     VoidCallback? onAdFailed,
//   }) {
//     _isScreenActive = true; // Mark screen as active
//
//     // Load the rewarded ad
//     RewardedAd.load(
//       adUnitId: "ca-app-pub-3940256099942544/5224354917", // Test Ad Unit ID
//       request: AdRequest(),
//       rewardedAdLoadCallback: RewardedAdLoadCallback(
//         onAdLoaded: (RewardedAd ad) {
//           if (!_isScreenActive) {
//             // If user has left the screen, dispose the ad and return
//             ad.dispose();
//             return;
//           }
//
//           _rewardedAd = ad;
//
//           ad.fullScreenContentCallback = FullScreenContentCallback(
//             onAdDismissedFullScreenContent: (Ad ad) {
//               _disposeAd();
//             },
//             onAdFailedToShowFullScreenContent: (Ad ad, AdError error) {
//               _disposeAd();
//               if (onAdFailed != null) {
//                 onAdFailed();
//               }
//             },
//           );
//
//           ad.show(
//             onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
//               onRewardEarned();
//             },
//           );
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           print('Failed to load rewarded ad: $error');
//           if (onAdFailed != null) {
//             onAdFailed();
//           }
//         },
//       ),
//     );
//   }
//
//   static void onScreenExit() {
//     // Call this when the screen is disposed
//     _isScreenActive = false;
//     _disposeAd();
//   }
//
//   static void _disposeAd() {
//     _rewardedAd?.dispose();
//     _rewardedAd = null;
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdHelper {
  static RewardedAd? _rewardedAd;
  static bool _isScreenActive = true; // Track screen activity

  static void showRewardedAd({
    required BuildContext context,
    required VoidCallback onRewardEarned,
    VoidCallback? onAdFailed,
  }) {
    _isScreenActive = true;

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing
      builder: (context) {
        return Center(
          child: AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16,),
                Text("Rewarded Ad Loading...."),
              ],
            ),
          ), // Loader
        );
      },
    );

    // Load the rewarded ad
    RewardedAd.load(
      adUnitId: "ca-app-pub-3940256099942544/5224354917", // Test Ad Unit ID
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          if (!_isScreenActive) {
            // If user leaves the screen before ad loads, dispose it
            ad.dispose();
            _closeLoader(context);
            return;
          }

          _rewardedAd = ad;

          // Close loader before showing the ad
          _closeLoader(context);

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (Ad ad) {
              _disposeAd();
            },
            onAdFailedToShowFullScreenContent: (Ad ad, AdError error) {
              _disposeAd();
              if (onAdFailed != null) {
                onAdFailed();
              }
            },
          );

          ad.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
              onRewardEarned();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Failed to load rewarded ad: $error');
          _closeLoader(context); // Hide loader on failure
          if (onAdFailed != null) {
            onAdFailed();
          }
        },
      ),
    );
  }

  static void _closeLoader(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context); // Close the loader dialog
    }
  }

  static void onScreenExit() {
    _isScreenActive = false;
    _disposeAd();
  }

  static void _disposeAd() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
  }
}
