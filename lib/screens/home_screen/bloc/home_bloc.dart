import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/home_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  InterstitialAd? _interstitialAd;

  HomeBloc(HomeState initialState) : super(initialState) {
    on<HomeInitialEvent>(_onInitialize);
    on<ShowAdEvent>(_onShowAd);
  }

  void _onInitialize(HomeInitialEvent event, Emitter<HomeState> emit) async {
    // Preload the interstitial ad
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint("Interstitial Ad failed to load: $error");
        },
      ),
    );
  }

  void _onShowAd(ShowAdEvent event, Emitter<HomeState> emit) async {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          debugPrint("Ad dismissed");
          _interstitialAd!.dispose();
          _interstitialAd = null;
          add(HomeInitialEvent()); // Reload ad
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          debugPrint("Ad failed to show: $error");
          ad.dispose();
        },
      );
      _interstitialAd!.show();
    } else {
      debugPrint("Ad not ready yet");
    }
  }
}
