import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdHelper {
  static void showRewardedAd({
    required BuildContext context,
    required VoidCallback onRewardEarned,
    VoidCallback? onAdFailed,
  }) {
    RewardedAd.load(
      adUnitId: "ca-app-pub-3940256099942544/5224354917", // Test Ad Unit ID
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          ad.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
              // Call the reward callback
              onRewardEarned();

            },
          );

          // Dispose the ad after it's shown
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (Ad ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (Ad ad, AdError error) {
              ad.dispose();
              if (onAdFailed != null) {
                onAdFailed();
              }
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Failed to load rewarded ad: $error');
          if (onAdFailed != null) {
            onAdFailed();
          }
        },
      ),
    );
  }
}
