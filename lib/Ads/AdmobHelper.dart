import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'banner_ad.dart';

class AdMobHelper{

  static String get bannerUnit => 'ca-app-pub-3940256099942544/9214589741';

  static initialization(){
      if(MobileAds.instance == null){
        MobileAds.instance.initialize();
      }
  }

  static BannerAdWidget getBannerAd(){

     return BannerAdWidget();
  }
}