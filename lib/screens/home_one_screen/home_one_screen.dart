// //
// // import 'package:flutter/material.dart';
// // //import 'package:flutter_bloc/flutter_bloc.dart';
// //
// // import '../../core/app_export.dart';
// // import '../../widgets/app_bar/appbar_leading_image.dart';
// // import '../../widgets/app_bar/appbar_trailing_button.dart';
// // import '../../widgets/app_bar/appbar_trailing_image.dart';
// // import '../../widgets/app_bar/custom_app_bar.dart';
// // import 'bloc/home_one_bloc.dart';
// //
// // class HomeOneScreen extends StatelessWidget {
// //   const HomeOneScreen({Key? key}) : super(key: key);
// //
// //   static Widget builder(BuildContext context) {
// //     return BlocProvider(
// //       create: (context) => HomeOneBloc(ApiService())..add(FetchWallpapersEvent()),
// //       child: HomeOneScreen(),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         appBar: PreferredSize(
// //           preferredSize: Size.fromHeight(120.0), // Set height for the custom app bar
// //           child: _buildTopAppBar(context),
// //         ),
// //         body: Container(
// //           width: double.maxFinite,
// //           decoration: AppDecoration.lightThemeBackground,
// //           child: BlocBuilder<HomeOneBloc, HomeOneState>(
// //             builder: (context, state) {
// //               if (state.isLoading) {
// //                 return Center(child: CircularProgressIndicator());
// //               }
// //
// //               if (state.errorMessage != null) {
// //                 return Center(child: Text('Error: ${state.errorMessage}'));
// //               }
// //
// //               return SingleChildScrollView(
// //                 child: Column(
// //                   children: [
// //                     _buildFeaturedWallpapers(state.featuredWallpapers),
// //                     _buildSuggestedWallpapers(state.suggestedWallpapers),
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildTopAppBar(BuildContext context) {
// //     return Container(
// //       width: double.maxFinite,
// //       padding: EdgeInsets.symmetric(vertical: 10.h),
// //       decoration: AppDecoration.lightThemeBackground,
// //       child: Expanded(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             CustomAppBar(
// //               height: 30.h,
// //               leadingWidth: 46.h,
// //               leading: AppbarLeadingImage(
// //                 imagePath: ImageConstant.imgBack,
// //                 margin: EdgeInsets.only(left: 16.h),
// //                 onTap: () {
// //                   // Handle back button tap
// //                 },
// //               ),
// //               actions: [
// //                 AppbarTrailingButton(),
// //                 AppbarTrailingImage(
// //                   imagePath: ImageConstant.imgSearch,
// //                   height: 24.h,
// //                   width: 24.h,
// //                   margin: EdgeInsets.only(left: 12.h, right: 24.h),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 12.h),
// //             Padding(
// //               padding: EdgeInsets.only(left: 16.h),
// //               child: Text(
// //                 S.current.lbl_wallpaper,
// //                 style: theme.textTheme.headlineSmall,
// //               ),
// //             ),
// //             SizedBox(height: 2.h),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildFeaturedWallpapers(List<dynamic> wallpapers) {
// //     if (wallpapers.isEmpty) {
// //       return Padding(
// //         padding: EdgeInsets.all(16),
// //         child: Text('No featured wallpapers available.', style: TextStyle(fontSize: 16)),
// //       );
// //     }
// //
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Padding(
// //           padding: EdgeInsets.all(16),
// //           child: Text('Featured Wallpapers', style: TextStyle(fontSize: 20)),
// //         ),
// //         SingleChildScrollView(
// //           scrollDirection: Axis.horizontal,
// //           child: Row(
// //             children: wallpapers.map((wallpaper) {
// //               final imageUrl = wallpaper['imageUrl'] ?? ""; // Fallback to empty string
// //               return Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: imageUrl.isNotEmpty
// //                     ? Image.network(
// //                   imageUrl,
// //                   width: 150,
// //                   height: 200,
// //                   fit: BoxFit.cover,
// //                 )
// //                     : Placeholder(fallbackHeight: 200, fallbackWidth: 150),
// //               );
// //             }).toList(),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildSuggestedWallpapers(List<dynamic> wallpapers) {
// //     if (wallpapers.isEmpty) {
// //       return Padding(
// //         padding: EdgeInsets.all(16),
// //         child: Text('No suggested wallpapers available.', style: TextStyle(fontSize: 16)),
// //       );
// //     }
// //
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Padding(
// //           padding: EdgeInsets.all(16),
// //           child: Text('Suggested Wallpapers', style: TextStyle(fontSize: 20)),
// //         ),
// //         GridView.builder(
// //           padding: EdgeInsets.all(16),
// //           shrinkWrap: true,
// //           physics: NeverScrollableScrollPhysics(),
// //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //             crossAxisCount: 2,
// //             crossAxisSpacing: 8,
// //             mainAxisSpacing: 8,
// //             childAspectRatio: 0.8,
// //           ),
// //           itemCount: wallpapers.length,
// //           itemBuilder: (context, index) {
// //             final imageUrl = wallpapers[index]['imageUrl'] ?? ""; // Fallback to empty string
// //             return imageUrl.isNotEmpty
// //                 ? Image.network(
// //               imageUrl,
// //               fit: BoxFit.cover,
// //             )
// //                 : Placeholder(fallbackHeight: 200, fallbackWidth: 150);
// //           },
// //         ),
// //       ],
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// //import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../core/app_export.dart';
// import '../../widgets/app_bar/appbar_leading_image.dart';
// import '../../widgets/app_bar/appbar_trailing_button.dart';
// import '../../widgets/app_bar/appbar_trailing_image.dart';
// import '../../widgets/app_bar/custom_app_bar.dart';
// import 'bloc/home_one_bloc.dart';
//
// class HomeOneScreen extends StatelessWidget {
//   const HomeOneScreen({Key? key}) : super(key: key);
//
//   static Widget builder(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeOneBloc(ApiService())..add(FetchWallpapersEvent()),
//       child: HomeOneScreen(),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(120.0), // Set height for the custom app bar
//           child: _buildTopAppBar(context),
//         ),
//         body: Container(
//           width: double.maxFinite,
//           decoration: AppDecoration.lightThemeBackground,
//           child: BlocBuilder<HomeOneBloc, HomeOneState>(
//             builder: (context, state) {
//               if (state.isLoading) {
//                 return Center(child: CircularProgressIndicator());
//               }
//
//               if (state.errorMessage != null) {
//                 return Center(child: Text('Error: ${state.errorMessage}'));
//               }
//
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     _buildHorizontalAvatars(),
//                     _buildFeaturedWallpapers(state.featuredWallpapers),
//                     _buildSuggestedWallpapers(state.suggestedWallpapers),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         bottomNavigationBar: _buildBottomNavigationBar(),
//       ),
//     );
//   }
//
//   Widget _buildTopAppBar(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       padding: EdgeInsets.symmetric(vertical: 10.h),
//       decoration: AppDecoration.lightThemeBackground,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CustomAppBar(
//             height: 30.h,
//             leadingWidth: 46.h,
//             leading: AppbarLeadingImage(
//               imagePath: ImageConstant.imgBack,
//               margin: EdgeInsets.only(left: 16.h),
//               onTap: () {
//                 // Handle back button tap
//               },
//             ),
//             actions: [
//               AppbarTrailingButton(),
//               AppbarTrailingImage(
//                 imagePath: ImageConstant.imgSearch,
//                 height: 24.h,
//                 width: 24.h,
//                 margin: EdgeInsets.only(left: 12.h, right: 24.h),
//               ),
//             ],
//           ),
//           SizedBox(height: 12.h),
//           Padding(
//             padding: EdgeInsets.only(left: 16.h),
//             child: Text(
//               S.current.lbl_wallpaper,
//               style: theme.textTheme.headlineSmall,
//             ),
//           ),
//           SizedBox(height: 2.h),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHorizontalAvatars() {
//     return Container(
//       height: 80, // Set a fixed height for the avatar scrollview
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 10, // Replace with dynamic list count if needed
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.only(right: 16),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: CircleAvatar(
//                     radius: 30,
//                     backgroundImage: NetworkImage(
//                       'https://via.placeholder.com/150', // Replace with actual image URLs
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Expanded(
//                   child: Text(
//                     'Avatar $index',
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildBottomNavigationBar() {
//     // Provide your custom bottom bar code if applicable
//     return BottomNavigationBar(
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.favorite),
//           label: 'Favorites',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.settings),
//           label: 'Settings',
//         ),
//       ],
//       currentIndex: 0, // Set initial index dynamically if needed
//       onTap: (index) {
//         // Handle bottom navigation tap
//       },
//     );
//   }
//
//   Widget _buildFeaturedWallpapers(List<dynamic> wallpapers) {
//     if (wallpapers.isEmpty) {
//       return Padding(
//         padding: EdgeInsets.all(16),
//         child: Text('No featured wallpapers available.', style: TextStyle(fontSize: 16)),
//       );
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.all(16),
//           child: Text('Featured Wallpapers', style: TextStyle(fontSize: 20)),
//         ),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: wallpapers.map((wallpaper) {
//               final imageUrl = wallpaper['imageUrl'] ?? ""; // Fallback to empty string
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: imageUrl.isNotEmpty
//                     ? Image.network(
//                   imageUrl,
//                   width: 150,
//                   height: 200,
//                   fit: BoxFit.cover,
//                 )
//                     : Placeholder(fallbackHeight: 200, fallbackWidth: 150),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSuggestedWallpapers(List<dynamic> wallpapers) {
//     if (wallpapers.isEmpty) {
//       return Padding(
//         padding: EdgeInsets.all(16),
//         child: Text('No suggested wallpapers available.', style: TextStyle(fontSize: 16)),
//       );
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.all(16),
//           child: Text('Suggested Wallpapers', style: TextStyle(fontSize: 20)),
//         ),
//         GridView.builder(
//           padding: EdgeInsets.all(16),
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 8,
//             mainAxisSpacing: 8,
//             childAspectRatio: 0.8,
//           ),
//           itemCount: wallpapers.length,
//           itemBuilder: (context, index) {
//             final imageUrl = wallpapers[index]['imageUrl'] ?? ""; // Fallback to empty string
//             return imageUrl.isNotEmpty
//                 ? Image.network(
//               imageUrl,
//               fit: BoxFit.cover,
//             )
//                 : Placeholder(fallbackHeight: 200, fallbackWidth: 150);
//           },
//         ),
//       ],
//     );
//   }
// }



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallpaper_2/screens/choose_language_screen/choose_language.dart';
import 'package:wallpaper_2/screens/FullScreenView/fullwallpaper_view.dart';
//import 'package:wallpaper_2/screens/premium_screen/premium_screen.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_trailing_button.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../categoriesDetails/category_detail_screen.dart';
import '../paywall_screen/paywall_screen.dart';
import 'bloc/home_one_bloc.dart';
//import 'custom_bottom_bar.dart'; // Import your custom bottom bar
// import 'package:cupertino_icons/cupertino_icons.dart';
class AvatarData {
  final Color color;
  //final String imagePath; // Change from icon to imagePath
 final IconData icon;
  final String label;

  AvatarData({required this.color, required this.icon, required this.label});
}


class HomeOneScreen extends StatefulWidget {
  const HomeOneScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeOneBloc(ApiService())..add(FetchWallpapersEvent()),
      child: const HomeOneScreen(),
    );
  }

  @override
  State<HomeOneScreen> createState() => _HomeOneScreenState();
}

class _HomeOneScreenState extends State<HomeOneScreen> {

  // Variables to hold cached data
  List<dynamic>? cachedFeaturedWallpapers;
  List<dynamic>? cachedSuggestedWallpapers;


  // Function to fetch data only if not cached
  void fetchDataOnce() {
    // if (cachedFeaturedWallpapers == null || cachedSuggestedWallpapers == null) {
    //   // Your API call or BLoC event goes here
    //   context.read<HomeOneBloc>().add(FetchWallpapersEvent());
    // }
    if (cachedFeaturedWallpapers == null || cachedFeaturedWallpapers!.isEmpty) {
      context.read<HomeOneBloc>().add(FetchWallpapersEvent());
    }
    if (cachedSuggestedWallpapers == null || cachedSuggestedWallpapers!.isEmpty) {
      context.read<HomeOneBloc>().add(FetchWallpapersEvent());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataOnce(); // Call this to fetch data only once when the screen is first built
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110.h),
          // Set height for the custom app bar
          child: _buildTopAppBar(context),
        ),
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.lightThemeBackground,
          child: BlocBuilder<HomeOneBloc, HomeOneState>(
            builder: (context, state) {
              // if (state.isLoading) {
              //   return Center(child: CircularProgressIndicator());
              // }
              //
              // if (state.errorMessage != null) {
              //   return Center(child: Text('Error: ${state.errorMessage}'));
              // }
              // Handle loading state
              if (state.isLoading && cachedFeaturedWallpapers == null) {
                return const Center(child: CircularProgressIndicator());
              }

              // Handle error message
              if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              }

              // Cache data if it's the first time
              if (cachedFeaturedWallpapers == null && state.featuredWallpapers.isNotEmpty) {
                cachedFeaturedWallpapers = state.featuredWallpapers;
              }

              if (cachedSuggestedWallpapers == null && state.suggestedWallpapers.isNotEmpty) {
                cachedSuggestedWallpapers = state.suggestedWallpapers;
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 12.h,),
                    _buildHorizontalAvatars(),
                    SizedBox(height: 12.h,),
                    _buildFeaturedWallpapers(cachedFeaturedWallpapers ?? state.featuredWallpapers),
                    SizedBox(height: 12.h,),
                    _buildSuggestedWallpapers(cachedSuggestedWallpapers ?? state.suggestedWallpapers),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTopAppBar(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: AppDecoration.lightThemeBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAppBar(
            height: 30.h,
            leadingWidth: 46.h,
            leading: AppbarLeadingImage(
              imagePath: ImageConstant.imgBack,
              margin: EdgeInsets.only(left: 16.h),
              onTap: () {},
            ),
            actions: [
              AppbarTrailingButton(
                onTap: () {
                  print("AppbarTrailingButton tapped!");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaywallScreen()),
                  );
                },
              ),
              AppbarTrailingImage(
                imagePath: ImageConstant.imgSearch,
                height: 24.h,
                width: 24.h,
                margin: EdgeInsets.only(left: 12.h, right: 24.h),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              S.current.lbl_wallpaper,
              style: theme.textTheme.headlineSmall,
            ),
          ),
          //SizedBox(height: 2.h),
        ],
      ),
    );
  }




// Utility function to convert hex color code to Color
  Color hexToColor(String hexColor) {
    final buffer = StringBuffer();
    if (hexColor.length == 6 || hexColor.length == 7) {
      buffer.write('FF'); // Add alpha value
      buffer.write(hexColor.replaceFirst('#', ''));
    } else if (hexColor.length == 8) {
      buffer.write(hexColor.replaceFirst('#', ''));
    } else {
      throw const FormatException("Invalid hex color format");
    }
    return Color(int.parse('0x${buffer.toString()}'));
  }

  Widget _buildHorizontalAvatars() {
    // List of avatar data with hex colors and third-party icons
    final List<AvatarData> avatars = [
      AvatarData(color: hexToColor("#FD7E46"), icon: FontAwesomeIcons.image, label: S.current.lbl_photos),
      AvatarData(color: hexToColor("#119398"), icon: FontAwesomeIcons.user, label: S.current.lbl_people),
      AvatarData(color: hexToColor("#0BBE62"), icon: FontAwesomeIcons.random, label: S.current.lbl_photo_shuffle),
      AvatarData(color: hexToColor("#2196F3"), icon: FontAwesomeIcons.stream, label: S.current.lbl_live_photo),
      AvatarData(color: hexToColor("#FC4487"), icon: FontAwesomeIcons.faceSmile, label: S.current.lbl_emoji),
      AvatarData(color: hexToColor("#312E35"), icon: FontAwesomeIcons.palette, label: S.current.lbl_color),
      AvatarData(color: hexToColor("#F59F2E"), icon: FontAwesomeIcons.userAstronaut, label: S.current.lbl_astro),
      AvatarData(color: hexToColor("#09AD54"), icon: FontAwesomeIcons.cloudSun, label: S.current.lbl_weather),
      //AvatarData(color: hexToColor("#09AD54"), icon: FontAwesomeIcons.camera, label: 'Avatar 9'),
      //AvatarData(color: hexToColor("#808080"), icon: FontAwesomeIcons.search, label: 'Avatar 10'),
    ];

    return Container(
      height: 80.h, // Set a fixed height for the avatar scrollview
      //width: double.maxFinite,
      //padding: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.only(left: 16.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: avatars.length, // Use the length of the avatars list
        itemBuilder: (context, index) {
          final avatar = avatars[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryDetailScreen(
                    title: avatar.label, // Pass the category title
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center the content
                children: [
                  CircleAvatar(
                    radius: 30.h,
                    backgroundColor: avatar.color, // Set the background color
                    child: Icon(
                      avatar.icon,
                      color: Colors.white,
                      size: 24.h,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: Text(
                      avatar.label, // Use the label from the AvatarData
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge,
                      textAlign: TextAlign.center, // Center the text
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  // Widget _buildFeaturedWallpapers(List<dynamic> wallpapers) {
  //   if (wallpapers.isEmpty) {
  //     return const Padding(
  //       padding: EdgeInsets.all(16),
  //       child: Text('No featured wallpapers available.',
  //           style: TextStyle(fontSize: 16)),
  //     );
  //   }
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.only(left: 16.h),
  //         child: Text(
  //           S.current.lbl_featured,
  //           style: theme.textTheme.titleLarge,
  //         ),
  //       ),
  //       SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: Row(
  //           children: wallpapers.map((wallpaper) {
  //             final imageUrl = wallpaper['download_url'] ??
  //                 ""; // Fallback to empty string
  //             final imageTitle = wallpaper['title'] ?? "Untitled"; // Title fallback
  //             final index = wallpapers.indexOf(wallpaper);  // Get index of the current wallpaper
  //             final isPremium = (index + 1) % 4 == 0; // Determine if the wallpaper is premium
  //
  //             return Padding(
  //               padding: EdgeInsets.only(left: 16.h, top: 8.h,),
  //               child: GestureDetector(
  //                 onTap: () {
  //                   if (imageUrl.isNotEmpty) {
  //                     //final isPremium = (index + 1) % 4 == 0; // Determine if the wallpaper is premium
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) =>
  //                             FullScreenWallpaperPage(
  //                                 //imageUrl: imageUrl
  //                               wallpapers: wallpapers,  // Pass the entire list
  //                               initialIndex: wallpapers.indexOf(wallpaper),  // Pass the selected index
  //                               isPremium: isPremium,
  //                             ),
  //                       ),
  //                     );
  //                   }
  //                 },
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Stack(
  //                       children:[ ClipRRect(
  //                         borderRadius: BorderRadius.circular(14), // Rounded corners
  //                         child: imageUrl.isNotEmpty
  //                             ? CachedNetworkImage(
  //                           imageUrl: imageUrl,
  //                           width: 98.h,
  //                           height: 207.h,
  //                           fit: BoxFit.cover,
  //                         )
  //                             : const Placeholder(
  //                           fallbackHeight: 207,
  //                           fallbackWidth: 98,
  //                         ),
  //                       ),
  //                         if(isPremium) Positioned(
  //                           child: CustomImageView(
  //                             imagePath: ImageConstant.imgPremium,
  //                             height: 26.h,
  //                             width: 26.h,
  //                           ),
  //                           //Icon(Icons.workspace_premium,color: Colors.amber,),
  //                           top: 6.h,
  //                           left: 66.h,
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(height: 8.h), // Space between image and text
  //                     Text(
  //                       imageTitle,
  //                       style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildFeaturedWallpapers(List<dynamic> wallpapers) {
    if (wallpapers.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No featured wallpapers available.', style: TextStyle(fontSize: 16)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.h),
          child: Text(
            S.current.lbl_featured,
            style: theme.textTheme.titleLarge,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: wallpapers.asMap().entries.map((entry) {
              final int index = entry.key;
              final wallpaper = entry.value;
              final imageUrl = wallpaper['download_url'] ?? "";
              final imageTitle = wallpaper['title'] ?? "Untitled";
              final bool isPremium = (index + 1) % 4 == 0; // ✅ Ensure correct premium wallpaper check

              return Padding(
                padding: EdgeInsets.only(left: 16.h, top: 8.h),
                child: GestureDetector(
                  onTap: () {
                    if (imageUrl.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenWallpaperPage(
                            wallpapers: wallpapers,
                            initialIndex: index, // ✅ Pass the correct index
                            isPremiumList: wallpapers.asMap().entries.map((entry) => (entry.key + 1) % 4 == 0).toList().cast<bool>(),
                          ),
                        ),
                      );
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: imageUrl.isNotEmpty
                                ? CachedNetworkImage(
                              imageUrl: imageUrl,
                              width: 98.h,
                              height: 207.h,
                              fit: BoxFit.cover,
                            )
                                : const Placeholder(fallbackHeight: 207, fallbackWidth: 98),
                          ),
                          if (isPremium)
                            Positioned(
                              child: CustomImageView(
                                imagePath: ImageConstant.imgPremium,
                                height: 26.h,
                                width: 26.h,
                              ),
                              top: 6.h,
                              left: 66.h,
                            ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        imageTitle,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }



  Widget _buildSuggestedWallpapers(List<dynamic> wallpapers) {
    if (wallpapers.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'No suggested wallpapers available.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.h),
          child: Text(
            S.current.msg_suggested_wallpapers,
            style: theme.textTheme.titleLarge,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: wallpapers.map((wallpaper) {
              final imageUrl = wallpaper['download_url'] ?? ""; // Fallback to empty string
              final imageTitle = wallpaper['title'] ?? "Untitled"; // Title fallback
              final index = wallpapers.indexOf(wallpaper);  // Get index of the current wallpaper
              final isPremium = (index + 1) % 4 == 0; // Determine if the wallpaper is premium

              return Padding(
                padding: EdgeInsets.only(left: 16.h, top: 8.h,),
                child: GestureDetector(
                  onTap: () {
                    if (imageUrl.isNotEmpty) {
                      //final isPremium = (index + 1) % 4 == 0; // Determine if the wallpaper is premium
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenWallpaperPage(
                              //imageUrl: imageUrl
                            wallpapers: wallpapers,  // Pass the entire list
                            initialIndex: wallpapers.indexOf(wallpaper),  // Pass the selected index
                            isPremiumList: wallpapers.asMap().entries.map((entry) => (entry.key + 1) % 4 == 0).toList().cast<bool>(),
                          ),
                        ),
                      );
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children:[
                          ClipRRect(
                          borderRadius: BorderRadius.circular(14), // Rounded corners
                          child: imageUrl.isNotEmpty
                              ? CachedNetworkImage(
                            imageUrl: imageUrl,
                            width: 98.h,
                            height: 207.h,
                            fit: BoxFit.cover,
                          )
                              : Placeholder(
                            fallbackHeight: 207.h,
                            fallbackWidth: 98.h,
                          ),
                        ),
                          if(isPremium) Positioned(
                            child: CustomImageView(
                              imagePath: ImageConstant.imgPremium,
                              height: 26.h,
                              width: 26.h,
                            ),
                            //Icon(Icons.workspace_premium,color: Colors.amber,),
                            top: 6.h,
                            left: 66.h,
                          ),
                ],
                      ),
                      SizedBox(height: 8.h), // Space between image and text
                      Text(
                        imageTitle,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

}


///for additional

//Widget _buildSuggestedWallpapers(List<dynamic> wallpapers) {
  //   if (wallpapers.isEmpty) {
  //     return Padding(
  //       padding: EdgeInsets.all(16),
  //       child: Text('No suggested wallpapers available.',
  //           style: TextStyle(fontSize: 16)),
  //     );
  //   }
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.all(16.h),
  //         child: Text(S.current.msg_suggested_wallpapers,
  //           style: theme.textTheme.titleLarge,),
  //       ),
  //       GridView.builder(
  //         padding: EdgeInsets.all(16),
  //         shrinkWrap: true,
  //         physics: NeverScrollableScrollPhysics(),
  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 2,
  //           crossAxisSpacing: 8,
  //           mainAxisSpacing: 8,
  //           childAspectRatio: 0.8,
  //         ),
  //         itemCount: wallpapers.length,
  //         itemBuilder: (context, index) {
  //           final imageUrl = wallpapers[index]['download_url'/*'imageUrl'*/] ??
  //               ""; // Fallback to empty string
  //           return GestureDetector(
  //             onTap: () {
  //               if (imageUrl.isNotEmpty) {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => FullScreenWallpaperPage(imageUrl: imageUrl),
  //                   ),
  //                 );
  //               }
  //             },
  //             child: imageUrl.isNotEmpty
  //                 ? Image.network(
  //               imageUrl,
  //               width: 105,
  //               height: 206,
  //               fit: BoxFit.cover,
  //             )
  //                 : Placeholder(fallbackHeight: 200, fallbackWidth: 150),
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }