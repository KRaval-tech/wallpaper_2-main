// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:wallpaper_2/core/app_export.dart';
//
// class NativeVideoAdWidget extends StatefulWidget {
//   @override
//   _NativeVideoAdWidgetState createState() => _NativeVideoAdWidgetState();
// }
//
// class _NativeVideoAdWidgetState extends State<NativeVideoAdWidget> {
//
//   final String adUnitId = 'ca-app-pub-3940256099942544/1044960115';
//
//   NativeAd? _nativeAd;
//   bool _isAdLoaded = false;
//
//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//     _nativeAd = NativeAd(
//       adUnitId: adUnitId,
//       factoryId: 'videoNativeAd',
//       listener: NativeAdListener(
//           onAdLoaded: (_){
//             setState(() {
//               _isAdLoaded = true;
//             });
//             print("Ad Loaded");
//           },
//           onAdFailedToLoad: (ad,error){
//             print("Ad Failed to Load!");
//             ad.dispose();
//           }
//       ),
//       request: AdRequest(),
//     );
//     _nativeAd!.load();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _isAdLoaded
//         ? Container(
//       height: 250.h,
//       width: double.maxFinite,
//       child: AdWidget(ad: _nativeAd!),
//     )
//         : Center(child: CircularProgressIndicator());
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallpaper_2/core/app_export.dart';

class NativeVideoAdWidget extends StatefulWidget {
  @override
  _NativeVideoAdWidgetState createState() => _NativeVideoAdWidgetState();
}

class _NativeVideoAdWidgetState extends State<NativeVideoAdWidget> {

  final String adUnitId = 'ca-app-pub-3940256099942544/1044960115';

  NativeAd? _nativeAd;
  bool _isAdLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nativeAd = NativeAd(
      adUnitId: adUnitId,
      factoryId: 'videoNativeAd',
      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
          print("Ad Loaded");
        },
        onAdFailedToLoad: (ad, error) {
          print("Ad Failed to Load!");
          ad.dispose();
        },
      ),
      request: AdRequest(),
    );
    _nativeAd!.load();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nativeAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? Container(
      height: 250.h,
      width: double.maxFinite,
      child: AdWidget(ad: _nativeAd!),
    )
        : Center(
      child: Text(
        "Ad is loading...",
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
