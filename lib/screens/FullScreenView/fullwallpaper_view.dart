import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_2/Ads/interstitial_ad_helper.dart';
import 'package:wallpaper_2/Ads/rewarded_ad.dart';
import 'package:wallpaper_2/screens/FullScreenView/widgets/premium_icon.dart';
import 'package:wallpaper_2/screens/FullScreenView/widgets/swipe_up_to_apply.dart';

import '../../Ads/fullscreen_native_ad.dart';
import '../../core/app_export.dart';
import '../paywall_screen/paywall_screen.dart';

class FullScreenWallpaperPage extends StatefulWidget {
  final List<dynamic> wallpapers;
  final int initialIndex;
  //final bool isPremium;
  final List<bool> isPremiumList; // ✅ Receive isPremium status from HomeOneScreen


  const FullScreenWallpaperPage({
    super.key,
    required this.wallpapers,
    required this.initialIndex,
    required this.isPremiumList,
    //required this.isPremium,
  });

  @override
  _FullScreenWallpaperPageState createState() => _FullScreenWallpaperPageState();
}

class _FullScreenWallpaperPageState extends State<FullScreenWallpaperPage> with SingleTickerProviderStateMixin {
  static const platform = MethodChannel('com.wallpaper.wallpaper_2'); // Add this line
  late int currentIndex;
  late bool _isPremium;
  bool _isUnlocked = false;
  bool _isAdLoading = false;
  final InterstitialAdHelper _adHelper = InterstitialAdHelper();
  bool _hasAppliedOrReported = false;
  bool _isAdLoaded = false;
  late List<int> _adPositions; // Multiple ads ke positions
  late List<NativeAd?> _nativeAds;
  bool _isAdDismissed = false; // Track karega ki ad dismiss hui ya nahi
  List<dynamic> modifiedWallpapers=[]; // ✅ New list for wallpapers + ads
  late List<bool> modifiedPremiumList; // ✅ Maintain modified isPremium list

  late AnimationController _animationController;
  late Animation<double> _positionAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => loadAdInBackground());
    //_adHelper.loadAd();
    currentIndex = widget.initialIndex;
    _insertAdPositions();
    _preloadAds();
    //_isPremium = widget.isPremium;
    _generateModifiedWallpaperList(); // ✅ Adjust wallpapers list with ads
    //_setNextAdThreshold(); // Set the first random ad trigger
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _positionAnimation = Tween<double>(begin: 0.0, end: -75.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }
  Future<void> loadAdInBackground() async {
    await Future.delayed(const Duration(milliseconds: 200)); // Reduce UI block
    _adHelper.loadAd();
  }

  /// **Preload multiple ads**
  void _preloadAds() {
    _nativeAds = List.filled(_adPositions.length, null); // Placeholder for ads

    for (int i = 0; i < _adPositions.length; i++) {
      _nativeAds[i] = NativeAd(
        adUnitId: "ca-app-pub-3940256099942544/1044960115",
        factoryId: "full_native",
        request: const AdRequest(),
        listener: NativeAdListener(
          onAdLoaded: (Ad ad) {
            setState(() {
              _isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
          },
        ),
      )..load();
    }
  }
  /// **Random positions select karo ads ke liye**
  void _insertAdPositions() {
    _adPositions = []; // Ensure list is empty before adding new values
    if (widget.wallpapers.length > 5) {
      int totalAds = min(3, widget.wallpapers.length ~/ 3); // Max 3 ads, 1 ad per 3 wallpapers
      Set<int> uniquePositions = {}; // Unique positions ensure karne ke liye

      while (uniquePositions.length < totalAds) {
        int pos = Random().nextInt(widget.wallpapers.length);
        uniquePositions.add(pos);
      }
      _adPositions = uniquePositions.toList();
    }
  }

  /// **Modified list generate karo jo ads bhi include kare**
  void _generateModifiedWallpaperList() {
    modifiedWallpapers = List.from(widget.wallpapers);
    modifiedPremiumList = List.from(widget.isPremiumList); // ✅ Copy original premium list

    int adsInserted = 0;
    for (int pos in _adPositions) {
      int adjustedPos = pos + adsInserted;
      if (adjustedPos < modifiedWallpapers.length) {
        modifiedWallpapers.insert(adjustedPos, {"isAd": true});
        modifiedPremiumList.insert(adjustedPos, false); // ✅ Ads are never premium
        adsInserted++;
      }
    }
  }
  @override
  void dispose() {
    RewardedAdHelper.onScreenExit();
    _adHelper.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _unlockWallpaper(String wallpaperId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> unlockedWallpapers = prefs.getStringList('unlockedWallpapers') ?? [];

    if (!unlockedWallpapers.contains(wallpaperId)) {
      unlockedWallpapers.add(wallpaperId);
      await prefs.setStringList('unlockedWallpapers', unlockedWallpapers);
    }
  }

  void _showPremiumAlert() {
    if (_isPremium) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(27.h),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: CustomImageView(
                          imagePath: "assets/svg/close_circle.svg",
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.wallpapers[currentIndex]['download_url'],
                        height: 256.h,
                        width: 154.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Unlock this wallpaper",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.w700,
                        fontSize: 18.fSize,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Watch an ad to download this wallpaper for free, or subscribe to enjoy unlimited downloads.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.fSize,
                        color: Colors.black,
                        fontFamily: "SF Pro Display",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 16),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF50AAF9), Color(0xFF1972D6)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(13.h),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isAdLoading = true;
                              });
              
                              RewardedAdHelper.showRewardedAd(
                                context: context,
                                onRewardEarned: () {
                                  setState(() {
                                    _isAdLoading = false;
                                  });
                                  Navigator.pop(context);
                                  String wallpaperId = widget.wallpapers[currentIndex]['id'];
                                  _unlockWallpaper(wallpaperId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Wallpaper unlocked! Swipe up to apply."),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                },
                                onAdFailed: () {
                                  setState(() {
                                    _isAdLoading = false;
                                  });
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Ad failed to load. Try again!")),
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              minimumSize: Size(double.infinity, 48),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.h),
                              ),
                            ),
                            child: _isAdLoading
                                ? SizedBox(
                              width: 24.h,
                              height: 24.h,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 3,
                              ),
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomImageView(
                                  imagePath: "assets/svg/video_play.svg",
                                  height: 24.h,
                                  width: 24.h,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Watch ADS",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "SF Pro Display",
                                    fontSize: 18.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.black,
                                thickness: 1,
                                endIndent: 7,
                              ),
                            ),
                            Text(
                              "or",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.fSize,
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.black,
                                thickness: 1,
                                indent: 7,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFFFBC40), Color(0xFFFA7D2A)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(13.h),
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PaywallScreen(),
                                ),
                              );
                            },
                            icon: CustomImageView(
                              imagePath: "assets/images/crown.svg",
                              height: 24.h,
                              width: 24.h,
                            ),
                            label: Text(
                              "Go Premium",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.fSize,
                                fontFamily: "SF Pro Display",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              minimumSize: Size(double.infinity, 48),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.h),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void goToNextImage() {
    if (currentIndex + 1 < widget.wallpapers.length) {
      setState(() {
        currentIndex++;
        //_showAdIfNeeded();
        _isPremium = (widget.wallpapers.indexOf(widget.wallpapers[currentIndex]) + 1) % 4 == 0;
      });
    }
  }

  void goToPreviousImage() {
    if (currentIndex - 1 >= 0) {
      setState(() {
        currentIndex--;
        //_showAdIfNeeded();
        _isPremium = (widget.wallpapers.indexOf(widget.wallpapers[currentIndex]) + 1) % 4 == 0;
      });
    }
  }

  Future<void> _setWallpaper(String type, String imageUrl) async {
    _adHelper.showAd(context, () async {
      try {
        final String result = await platform.invokeMethod('setWallpaper', {'type': type, 'imageUrl': imageUrl});
        _hasAppliedOrReported = true;
        _showSuccessAlert('Wallpaper set successfully for $type screen','assets/svg/success.svg');
        print(result);
      } on PlatformException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to set wallpaper: '${e.message}'")),
        );
        print("Failed to set wallpaper: '${e.message}'.");
      }
    });
  }

  Future<void> _reportWallpaper(String imageUrl) async {
    try {
      final String result = await platform.invokeMethod('reportWallpaper', {'imageUrl': imageUrl});
      _hasAppliedOrReported = true;
      _showSuccessAlert('Wallpaper reported successfully', 'assets/svg/report_issue.svg');
      print(result);
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to report wallpaper: '${e.message}'")),
      );
      print("Failed to report wallpaper: '${e.message}'.");
    }
  }



  void _showSuccessAlert(String message, String imagePath) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const CustomImageView(
                      imagePath: "assets/svg/close_circle.svg",
                    ),
                  ),
                ),
                SvgPicture.asset(
                  imagePath,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 15),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 5), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }


  void _checkAndShowPremiumAlert() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> unlockedWallpapers = prefs.getStringList('unlockedWallpapers') ?? [];

    String wallpaperId = widget.wallpapers[currentIndex]['id'];

    final bool isCurrentWallpaperPremium = ((currentIndex + 1) % 4 == 0);

    if (isCurrentWallpaperPremium && !unlockedWallpapers.contains(wallpaperId)) {
      _showPremiumAlert();
    } else {
       _animationController.forward();
       Future.delayed(const Duration(milliseconds: 300),(){
         _showBottomSheet();
       });
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final wallpaper = widget.wallpapers[currentIndex];
        return Container(
          padding: EdgeInsets.all(8.h),
          height: 355.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Centered Line
              Container(
                width: 72, // Width of the line
                height: 4.h,  // Thickness of the line
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 16.h), // Space below the line
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: CustomImageView(
                        imagePath: ImageConstant.imgLock,
                        height: 18.h,
                        width: 18.h,
                      ),
                      title: Text("Set as Lock Screen", style: TextStyle(
                          color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                        fontSize: 16.fSize,
                      )),
                      onTap: () {
                        _setWallpaper('lock', wallpaper['download_url']);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: CustomImageView(
                        imagePath: ImageConstant.imgHome,
                        height: 18.h,
                        width: 18.h,
                      ),
                      title: Text("Set as Home Screen", style: TextStyle(
                          color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                        fontSize: 16.fSize,
                      )),
                      onTap: () {
                        _setWallpaper('home', wallpaper['download_url']);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: CustomImageView(
                        imagePath: ImageConstant.imgMouseSquare,
                        height: 18.h,
                        width: 18.h,
                      ),
                      title: Text("Set as Both", style: TextStyle(
                          color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                        fontSize: 16.fSize,
                      )),
                      onTap: () {
                        _setWallpaper('both', wallpaper['download_url']);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: CustomImageView(
                        imagePath: ImageConstant.imgDanger,
                        height: 18.h,
                        width: 18.h,
                      ),
                      title: Text("Report this Photo", style: TextStyle(
                          color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto",
                        fontSize: 16.fSize,
                      )),
                      onTap: () {
                        _reportWallpaper(wallpaper['download_url']);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      _animationController.reverse();
    });
  }

  @override
  // Widget build(BuildContext context) {
  //   final wallpaper = widget.wallpapers[currentIndex];
  //   final isCurrentWallpaperPremium = ((currentIndex + 1) % 4 == 0);
  //   return Scaffold(
  //     body: GestureDetector(
  //       onHorizontalDragEnd: (details) {
  //         // Detect swipe direction
  //         if (details.primaryVelocity! > 0) {
  //           // Swiped Right -> go to the previous image
  //           goToPreviousImage();
  //         } else if (details.primaryVelocity! < 0) {
  //           // Swiped Left -> go to the next image
  //           goToNextImage();
  //         }
  //       },
  //       child: Container(
  //         color: Colors.black,
  //         child: Stack(
  //           children: [
  //             // Image.network(
  //             //   wallpaper['download_url'],
  //             //   fit: BoxFit.cover,
  //             //   width: double.infinity,
  //             //   height: double.infinity,
  //             // ),
  //             CachedNetworkImage(
  //                 imageUrl: wallpaper['download_url'],
  //               fit: BoxFit.cover,
  //               width: double.infinity,
  //               height: double.infinity,
  //             ),
  //             PremiumIcon(isPremium: isCurrentWallpaperPremium),
  //             Align(
  //               alignment: Alignment.topLeft,
  //               child: Padding(
  //                 padding: const EdgeInsets.only(top: 70.0, left: 20.0),
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.white.withOpacity(0.2),
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                   child: IconButton(
  //                     padding: EdgeInsets.zero,
  //                     icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Align(
  //               alignment: Alignment.bottomCenter,
  //               child: Container(
  //                 height: 210,
  //                 decoration: BoxDecoration(
  //                   gradient: LinearGradient(
  //                     begin: Alignment.topCenter,
  //                     end: Alignment.bottomCenter,
  //                     colors: [
  //                       Colors.transparent,
  //                       Colors.black.withOpacity(0.2),
  //                     ],
  //                   ),
  //                   borderRadius: const BorderRadius.only(
  //                     topLeft: Radius.circular(20),
  //                     topRight: Radius.circular(20),
  //                   ),
  //                 ),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                    BottomControls(
  //                        onPrevious: goToPreviousImage,
  //                        onNext: goToNextImage,
  //                        onSwipeUp: _checkAndShowPremiumAlert,
  //                        animationController: _animationController, // Pass the controller
  //                        opacityAnimation: _opacityAnimation, // Pass the opacity animation
  //                        positionAnimation: _positionAnimation, // Pass the position animation
  //                    ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    final isAdPosition = modifiedWallpapers[currentIndex]["isAd"] == true;
    final adIndex = _adPositions.indexOf(currentIndex);
    final isValidAdIndex = adIndex != -1 && _nativeAds.isNotEmpty && _nativeAds.length > adIndex;

    // ✅ Ad index ke hisaab se actual wallpaper index calculate karein
    int actualWallpaperIndex = currentIndex;
    for (int pos in _adPositions) {
      if (currentIndex > pos) {
        actualWallpaperIndex--; // Ad se pehle ke wallpapers ke index adjust karo
      }
    }

    // ✅ Wallpaper safe check
    final wallpaper = isAdPosition ? null : widget.wallpapers[actualWallpaperIndex];
    //final isCurrentWallpaperPremium = !isAdPosition && ((actualWallpaperIndex + 1) % 4 == 0);
    final isCurrentWallpaperPremium = modifiedPremiumList[currentIndex]; // ✅ Maintain correct premium flag

    // ✅ Null check aur fallback image
    final String imageUrl = (!isAdPosition && modifiedWallpapers[currentIndex].containsKey('download_url'))
        ? modifiedWallpapers[currentIndex]['download_url'] ?? ''
        : ''; // ✅ Default empty string to avoid null errors

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            goToPreviousImage();
          } else if (details.primaryVelocity! < 0) {
            goToNextImage();
          }
        },
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              // **Ad ko ek normal wallpaper ki tarah dikhao**
              // if (isAdPosition && _isAdLoaded && adIndex != -1 && _nativeAds[adIndex] != null)
              //   Center(child: AdWidget(ad: _nativeAds[adIndex]!))
              if (isAdPosition && isValidAdIndex)
                Center(child: AdWidget(ad: _nativeAds[adIndex]!))
                //Center(child: AdWidget(ad: _nativeAds[_adPositions.indexOf(currentIndex)]!))
              else
                CachedNetworkImage(
                  //imageUrl: wallpaper['download_url'],
                  //imageUrl: modifiedWallpapers[currentIndex]['download_url'],
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),

              // **Ad par Premium Icon aur BottomControls na dikhaye**
              if (!isAdPosition) ...[
                PremiumIcon(isPremium: isCurrentWallpaperPremium),

                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70.0, left: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 210,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.2),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BottomControls(
                          onPrevious: goToPreviousImage,
                          onNext: goToNextImage,
                          onSwipeUp: _checkAndShowPremiumAlert,
                          animationController: _animationController,
                          opacityAnimation: _opacityAnimation,
                          positionAnimation: _positionAnimation,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }


}