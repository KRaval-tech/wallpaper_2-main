import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallpaper_2/core/app_export.dart';

class BannerAdWidget extends StatefulWidget {
  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late BannerAd? _bannerAd;
  bool _isBannerAdReady = false;


  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() async{
    // final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
    //   MediaQuery.of(context).size.width.truncate(),
    // );
    _bannerAd = BannerAd(
      size: AdSize.banner,
      //size: size,
      adUnitId: 'ca-app-pub-3940256099942544/9214589741', // Replace with your ad unit ID
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('BannerAd failed to load: $error');
        },
      ),
    );

    _bannerAd!.load();
  }

  @override
  void dispose() {
    _bannerAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isBannerAdReady) {
      return Container(
        alignment: Alignment.center,
       height: _bannerAd!.size.height.toDouble(),
        width: double.infinity,
      child: AdWidget(ad: _bannerAd!),
    );
    } else {
      return SizedBox(height: 50.h,child: Text("Loading Banner Ad......"),);
    } // Placeholder while loading
  }
}