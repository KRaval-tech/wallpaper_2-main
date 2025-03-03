import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallpaper_2/core/app_export.dart';

class ResponsiveNativeAd extends StatefulWidget {
  const ResponsiveNativeAd({super.key});

  @override
  _ResponsiveNativeAdState createState() => _ResponsiveNativeAdState();
}

class _ResponsiveNativeAdState extends State<ResponsiveNativeAd> {
  late NativeAd _nativeAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadNativeAd();
  }

  // Load Native Ad
  void _loadNativeAd() {
    _nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110', // Replace with your Native Ad unit ID
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
          print("Native Ad Loaded");
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print("Native Ad Failed to Load: $error");
        },
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium, // Can also try TemplateType.small or others
        mainBackgroundColor: Colors.white,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          style: NativeTemplateFontStyle.monospace,
          size: 14.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black,
          style: NativeTemplateFontStyle.normal,
          size: 14.0,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black,
          style: NativeTemplateFontStyle.normal,
          size: 12.0,
        ),
      ),
    )..load();
  }

  @override
  void dispose() {
    _nativeAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Flexible width
      height: 350, // Adjust height based on screen width
      alignment: Alignment.center, // Center align content
      child: _isAdLoaded
          ? AdWidget(ad: _nativeAd)
          : Text(
        "Ad is Loading",
        style: TextStyle(fontSize: 18,color: Colors.grey),
      ),
    );
  }
}
