import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_2/core/app_export.dart';

import '../../Ads/rewarded_ad.dart';
import '../paywall_screen/paywall_screen.dart';
//import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart'; // Import the svg package

class FullScreenWallpaperPage extends StatefulWidget {
//   final String imageUrl;
// //
//   const FullScreenWallpaperPage({Key? key, required this.imageUrl}) : super(key: key);

  final List<dynamic> wallpapers;  // Pass wallpapers list from HomeOneScreen
  final int initialIndex;          // Pass selected index
  final bool isPremium; // New property to indicate premium status

  const FullScreenWallpaperPage({
    Key? key,
    required this.wallpapers,
    required this.initialIndex,
    required this.isPremium, // Required parameter
  }) : super(key: key);


  @override
  _FullScreenWallpaperPageState createState() => _FullScreenWallpaperPageState();
}

class _FullScreenWallpaperPageState extends State<FullScreenWallpaperPage> with SingleTickerProviderStateMixin{
  //int currentIndex = 0; // Current index for the image or content to display
  static const platform = MethodChannel('com.wallpaper.wallpaper_2'); // Define MethodChannel
  late int currentIndex;
  late bool _isPremium;
  bool _isUnlocked = false;
  bool _isAdLoading = false;


  late AnimationController _animationController;
  late Animation<double> _positionAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _isPremium = widget.isPremium;
    currentIndex = widget.initialIndex;  // Initialize the current index

    // Initialize AnimationController for swipe-up animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Vertical movement animation for the circular container
    _positionAnimation =
        Tween<double>(begin: 0.0, end: -75.0).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOut,
        ));

    // Fade-out animation for the arrows
    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOut,
        ));
  }

  @override
  void dispose() {
    RewardedAdHelper.onScreenExit();
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
        barrierDismissible: false, // Prevent dismiss by tapping outside
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(27.h),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close Button
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                      },
                      //icon: Icon(Icons.close),
                      icon: CustomImageView(
                        imagePath: "assets/svg/close_circle.svg",
                      ),
                    ),
                  ),
                  // Wallpaper Preview
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      widget.wallpapers[currentIndex]['download_url'],
                      height: 256.h,
                      width: 154.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title
                  Text(
                    "Unlock this wallpaper",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "SF Pro Display",
                      fontWeight: FontWeight.w700,
                      fontSize: 18.fSize,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description
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
                  const SizedBox(height: 16),
                  // Buttons
                  Column(
                    children: [
                      //Watch Ads Button
                      // Watch Ads Button
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
                            //Navigator.pop(context);
                            setState(() {
                              _isAdLoading = true; // Start loader
                            });

                            RewardedAdHelper.showRewardedAd(
                              context: context,
                              onRewardEarned: () {
                                setState(() {
                                  _isAdLoading = false; // Stop loader
                                });
                                Navigator.pop(context); // Dialog close
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
                                  _isAdLoading = false; // Stop loader
                                });
                                Navigator.pop(context); // Dialog close on ad fail
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Ad failed to load. Try again!")),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, // Must be transparent to show gradient
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

                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.black, // Line color
                              thickness: 1, // Line thickness
                              endIndent: 7, // Space from text
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
                              color: Colors.black, // Line color
                              thickness: 1, // Line thickness
                              indent: 7, // Space from text
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Go Premium Button
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
                            Navigator.pop(context); // Close dialog
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaywallScreen(),
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
                            backgroundColor: Colors.transparent, // Must be transparent to show gradient
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
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      );
    }
  }


  // Move to next image
  void goToNextImage() {
    // setState(() {
    //   currentIndex = (currentIndex + 1) % widget.wallpapers.length;  // Wrap around to the first image if at the end
    // });
    if (currentIndex + 1 < widget.wallpapers.length) {
      setState(() {
        currentIndex++;
        _isPremium = (widget.wallpapers.indexOf(widget.wallpapers[currentIndex]) + 1) % 4 == 0;
      });
      //_showPremiumAlert(); // Show alert if next wallpaper is premium
    }
  }

  // Move to previous image
  void goToPreviousImage() {
    // setState(() {
    //   currentIndex = (currentIndex - 1 + widget.wallpapers.length) % widget.wallpapers.length;  // Wrap around to the last image if at the beginning
    // });
    if (currentIndex - 1 >= 0) {
      setState(() {
        currentIndex--;
        _isPremium = (widget.wallpapers.indexOf(widget.wallpapers[currentIndex]) + 1) % 4 == 0;
      });
      //_showPremiumAlert(); // Show alert if the previous wallpaper is premium
    }
  }

  // // Method to set the wallpaper
  // Future<void> _setWallpaper(String type, String imageUrl) async {
  //   try {
  //     // Define wallpaper location: home, lock, or both
  //     WallpaperLocation location;
  //
  //     switch (type) {
  //       case 'home':
  //         location = WallpaperLocation.home;
  //         break;
  //       case 'lock':
  //         location = WallpaperLocation.lock;
  //         break;
  //       case 'both':
  //         location = WallpaperLocation.both;
  //         break;
  //       default:
  //         throw Exception('Invalid wallpaper type');
  //     }
  //
  //     // Set the wallpaper
  //     bool result = await WallpaperManagerFlutter().setWallpaperFromNetwork(imageUrl, location);
  //
  //     if (result) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Wallpaper set successfully for $type screen')),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to set wallpaper')),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: $e')),
  //     );
  //   }
  // }

  // Function to show the bottom sheet
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final wallpaper = widget.wallpapers[currentIndex]; // Get the current wallpaper
        return Container(
          padding: EdgeInsets.all(16.0),
          height: 355.h, // Adjust height as needed
          child: ListView(
            children: [
              ListTile(
                leading: CustomImageView(
                  imagePath: ImageConstant.imgLock,
                  height: 18.h,
                  width: 18.h,
                ),//Icon(Icons.wallpaper, color: Colors.black),
                title: Text("Set as Lock Screen", style: TextStyle(color: Colors.black)),
                onTap: () {
                  // Handle action
                  print("Set as Lock Screen for ${wallpaper['download_url']}");
                  _setWallpaper('lock', wallpaper['download_url']);
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: CustomImageView(
              imagePath: ImageConstant.imgHome,
              height: 18.h,
              width: 18.h,
              ),
              //Icon(Icons.home, color: Colors.black),
                title: Text("Set as Home Screen", style: TextStyle(color: Colors.black)),
                onTap: () {
                  // Handle action
                  print("Set as Home Screen for ${wallpaper['download_url']}");
                  _setWallpaper('home', wallpaper['download_url']);
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: CustomImageView(
                  imagePath: ImageConstant.imgMouseSquare,
                  height: 18.h,
                  width: 18.h,
                ),
                //Icon(Icons.share, color: Colors.black),
                title: Text("Set as Both", style: TextStyle(color: Colors.black)),
                onTap: () {
                  // Handle action
                  print("Both");
                  _setWallpaper('both', wallpaper['download_url']);
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: CustomImageView(
                  imagePath: ImageConstant.imgDanger,
                  height: 18.h,
                  width: 18.h,
                ),
                //Icon(Icons.delete, color: Colors.black),
                title: Text("Report this Photo", style: TextStyle(color: Colors.black)),
                onTap: () {
                  // Handle action
                  print("Report");
                  _reportWallpaper(wallpaper['download_url']);
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      _animationController.reverse(); // Reset animation when the bottom sheet is closed
    });
  }

  // Function to set wallpaper with Snackbar
  Future<void> _setWallpaper(String type, String imageUrl) async {
    try {
      final String result =
      await platform.invokeMethod('setWallpaper', {'type': type, 'imageUrl': imageUrl});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wallpaper set successfully for $type screen')),
      );
      print(result); // Handle the response
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to set wallpaper: '${e.message}'")),
      );
      print("Failed to set wallpaper: '${e.message}'.");
    }
  }

  // Function to report wallpaper with Snackbar
  Future<void> _reportWallpaper(String imageUrl) async {
    try {
      final String result =
      await platform.invokeMethod('reportWallpaper', {'imageUrl': imageUrl});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wallpaper reported successfully')),
      );
      print(result); // Handle the response
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to report wallpaper: '${e.message}'")),
      );
      print("Failed to report wallpaper: '${e.message}'.");
    }
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
      Future.delayed(const Duration(milliseconds: 300), () {
        _showBottomSheet();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final wallpaper = widget.wallpapers[currentIndex];  // Get current wallpaper
    final isCurrentWallpaperPremium = ((currentIndex + 1) % 4 == 0); // Dynamically check if it's premium
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
        Image.network(
            //widget.imageUrl,
            wallpaper['download_url'],
            fit: BoxFit.cover, // Adjust based on your desired behavior
            width: double.infinity,
            height: double.infinity,
          ),


            // Premium icon if the wallpaper is premium
            if (isCurrentWallpaperPremium)
              Positioned(
                top: 70.h, // Adjust position as needed
                left: 294.h,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFFBC40), // Gradient color 1
                        Color(0xFFFA7D2A), // Gradient color 2
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(52.h), // Rounded corners
                  ),
                  padding: EdgeInsets.all(12.0), // Adjust padding as needed
                  child: Center(
                    child: CustomImageView(
                      imagePath: ImageConstant.imgNavPremium1,
                      height: 24.h,
                      width: 24.h,
                      color: Colors.white, // Tint the image with white color
                    ),
                  ),
                ),
              ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 70.0, left: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Transparent white
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero, // Remove default padding
                    icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Close the full-screen view on tap
                    },
                  ),
                ),
              ),
            ),
            // Bottom Control Bar
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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left SVG Image (replace with your own SVG file path)
                        Padding(
                          padding: EdgeInsets.only(),
                          child: GestureDetector(
                            onTap: goToPreviousImage,
                            child: SvgPicture.asset(
                              'assets/svg/left_icon.svg', // Replace with your SVG asset
                            ),
                          ),
                        ),

                        Column(
                          children: [
                            Container(
                              height: 130,
                              width: 54,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(39.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.3),
                                    offset: Offset(0, 8),
                                    spreadRadius: 0,
                                    blurRadius: 15.33,
                                  ),
                                ],
                              ),
                              child: AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, child) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Arrows with opacity animation
                                      Opacity(
                                        opacity: _opacityAnimation.value, // Animate arrow fading
                                        child: Column(
                                          children: [
                                            Icon(Icons.keyboard_arrow_up_rounded, color: Colors.black),
                                            Icon(Icons.keyboard_arrow_up_rounded,
                                                color: Colors.black.withOpacity(0.7)),
                                            Icon(Icons.keyboard_arrow_up_rounded,
                                                color: Colors.black.withOpacity(0.2)),
                                          ],
                                        ),
                                      ),
                                      // Black circular container with vertical animation
                                      Transform.translate(
                                        offset: Offset(0, _positionAnimation.value), // Animate vertical movement
                                        child: GestureDetector(
                                          onVerticalDragEnd: (details) {
                                            // if (details.primaryVelocity! < 0) {
                                            //   // Determine if the current wallpaper is premium.
                                            //   // (Using your logic: every 4th wallpaper is premium.)
                                            //   final bool isCurrentWallpaperPremium = ((currentIndex + 1) % 4 == 0);
                                            //   if (isCurrentWallpaperPremium && !_isUnlocked) {
                                            //     // For premium wallpapers, show the premium alert dialog.
                                            //     _showPremiumAlert();
                                            //   }else{
                                            //     _animationController.forward();
                                            //     Future.delayed(const Duration(milliseconds: 300),(){
                                            //       _showBottomSheet();
                                            //     });
                                            //   }
                                            // }
                                            if(details.primaryVelocity! < 0){
                                              _checkAndShowPremiumAlert();
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(2),
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.25),
                                                  offset: const Offset(0, 4),
                                                  spreadRadius: 0,
                                                  blurRadius: 6.2,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Swipe Up To Apply",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),


                        // Right SVG Image (replace with your own SVG file path)
                        Padding(
                          padding: EdgeInsets.only(),
                          child: GestureDetector(
                            onTap: goToNextImage,
                            child: SvgPicture.asset(
                              'assets/svg/right_icon.svg', // Replace with your SVG asset
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


