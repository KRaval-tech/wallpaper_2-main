// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:wallpaper_2/screens/categoriesDetails/bloc/category_detail_bloc.dart';
// import '../../core/app_export.dart';
// import '../../widgets/app_bar/appbar_trailing_button.dart';
// import '../../widgets/app_bar/appbar_trailing_image.dart';
// import '../FullScreenView/fullwallpaper_view.dart';
// import '../paywall_screen/paywall_screen.dart';
// import 'bloc/category_detail_event.dart';
// import 'bloc/category_detail_state.dart';
//
// class CategoryDetailScreen extends StatefulWidget {
//   final String title;
//
//   static Widget builder(BuildContext context, dynamic category) {
//     return BlocProvider(
//       create: (context) => CategoryDetailBloc(ApiService())..add(FetchCategoryWallpapers('')),
//       child: CategoryDetailScreen(title: category.name),
//     );
//   }
//
//   const CategoryDetailScreen({
//     super.key,
//     required this.title,
//   });
//
//   @override
//   State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
// }
//
// class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           _buildTopAppBar(context), // Custom AppBar added here
//           Expanded(
//             child: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
//               builder: (context, state) {
//                 if (state is CategoryDetailLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is CategoryDetailLoaded) {
//                   final allWallpapers = [...state.wallpapers, ...state.wallpaper2]; // Dono lists merge
//                   return GridView.builder(
//                     shrinkWrap: true,
//                     padding: const EdgeInsets.all(16),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       mainAxisSpacing: 12,
//                       crossAxisSpacing: 12,
//                       childAspectRatio: 107.h / 216.h,
//                     ),
//                     //itemCount: state.wallpapers.length,
//                     itemCount: allWallpapers.length,
//                     itemBuilder: (context, index) {
//                       //final wallpaper = state.wallpapers[index];
//                       final wallpaper = allWallpapers[index];
//                       return GestureDetector(
//                         onTap: () {
//                           final isPremium = (index + 1) % 4 == 0; // Determine if the wallpaper is premium
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => FullScreenWallpaperPage(
//                                 //wallpapers: state.wallpapers, // Pass all wallpapers
//                                 wallpapers: allWallpapers,
//                                 initialIndex: index, // Pass the tapped wallpaper index
//                                 isPremium: isPremium,
//                               ),
//                             ),
//                           );
//                           // If the wallpaper is premium, delay the dialog to ensure the page is rendered first
//                           // if (isPremium) {
//                           //   Future.delayed(Duration(milliseconds: 200), () {
//                           //     showDialog(
//                           //       context: context,
//                           //       barrierDismissible: false, // Prevent dismissing without action
//                           //       builder: (context) {
//                           //         return AlertDialog(
//                           //           title: Text("Premium Wallpaper"),
//                           //           content: Text("Unlock premium wallpapers by upgrading to the premium plan."),
//                           //           actions: [
//                           //             TextButton(
//                           //               onPressed: () {
//                           //                 Navigator.pop(context); // Close the dialog
//                           //               },
//                           //               child: Text("Cancel"),
//                           //             ),
//                           //             ElevatedButton(
//                           //               onPressed: () {
//                           //                 Navigator.pop(context); // Close the dialog
//                           //                 Navigator.push(
//                           //                   context,
//                           //                   MaterialPageRoute(
//                           //                     builder: (context) => PaywallScreen(), // Navigate to the paywall screen
//                           //                   ),
//                           //                 );
//                           //               },
//                           //               child: Text("Go Premium"),
//                           //             ),
//                           //           ],
//                           //         );
//                           //       },
//                           //     );
//                           //   });
//                           // }
//                         },
//                         child: Stack(
//                           children: [
//                             // Container(
//                             //   decoration: BoxDecoration(
//                             //     borderRadius: BorderRadius.circular(6),
//                             //     image: DecorationImage(
//                             //       image: NetworkImage(wallpaper["download_url"]),
//                             //       fit: BoxFit.cover,
//                             //     ),
//                             //   ),
//                             // ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(6),
//                                 image: DecorationImage(
//                                   image: CachedNetworkImageProvider(
//                                     wallpaper["download_url"] ?? "assets/images/placeholder.jpg",
//                                   ),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             if ((index + 1) % 4 == 0)
//                               Positioned(
//                                 top: 5.h,
//                                 left: 76.h,
//                                 child: CustomImageView(
//                                   imagePath: ImageConstant.imgPremium,
//                                   height: 26.h,
//                                   width: 26.h,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 } else if (state is CategoryDetailError) {
//                   return Center(child: Text(state.message));
//                 }
//                 return const Center(child: Text('No wallpapers available.'));
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTopAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//       title: Text(
//         widget.title,
//         style: theme.textTheme.headlineSmall,
//       ),
//       actions: [
//         AppbarTrailingButton(
//           onTap: () {
//             if (kDebugMode) {
//               print("AppbarTrailingButton tapped!");
//             }
//             // Navigator.of(context).push(
//             //   // context,
//             //   // MaterialPageRoute(builder: (context) => PaywallScreen()),
//             //   PageRouteBuilder(
//             //     pageBuilder: (context, animation, secondaryAnimation) => PaywallScreen(),
//             //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             //       return FadeTransition(opacity: animation, child: child);
//             //     },
//             //   ),
//             // );
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const PaywallScreen()),
//             );
//           },
//         ),
//         AppbarTrailingImage(
//           imagePath: ImageConstant.imgSearch,
//           height: 24.h,
//           width: 24.h,
//           margin: EdgeInsets.only(left: 12.h, right: 24.h),
//         ),
//       ],
//     );
//   }
// }



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_2/screens/paywall_screen/paywall_screen.dart';

import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_trailing_button.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../FullScreenView/fullwallpaper_view.dart';
import 'bloc/category_detail_bloc.dart';
import 'bloc/category_detail_event.dart';
import 'bloc/category_detail_state.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String title;

  static Widget builder(BuildContext context, dynamic category) {
    return BlocProvider(
      create: (context) => CategoryDetailBloc(ApiService())..add(FetchCategoryWallpapers('')),
      child: CategoryDetailScreen(title: category.name),
    );
  }

  const CategoryDetailScreen({
    super.key,
    required this.title,
  });

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildTopAppBar(context),
          Expanded(
            child: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
              builder: (context, state) {
                if (state is CategoryDetailLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CategoryDetailLoaded) {
                  final allWallpapers = [...state.wallpapers, ...state.wallpaper2]; // ✅ Merge both wallpaper lists
                  final isPremiumList = allWallpapers
                      .asMap()
                      .entries
                      .map((entry) => (entry.key + 1) % 4 == 0)
                      .toList(); // ✅ Generate isPremium list

                  return GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 107.h / 216.h,
                    ),
                    itemCount: allWallpapers.length,
                    itemBuilder: (context, index) {
                      final wallpaper = allWallpapers[index];
                      final bool isPremium = isPremiumList[index]; // ✅ Use precomputed premium status

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenWallpaperPage(
                                wallpapers: allWallpapers,
                                initialIndex: index,
                                isPremiumList: isPremiumList, // ✅ Pass isPremium list
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    wallpaper["download_url"] ?? "assets/images/placeholder.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (isPremium)
                              Positioned(
                                top: 5.h,
                                left: 76.h,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgPremium,
                                  height: 26.h,
                                  width: 26.h,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is CategoryDetailError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('No wallpapers available.'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        widget.title,
        style: theme.textTheme.headlineSmall,
      ),
      actions: [
        AppbarTrailingButton(
          onTap: () {
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
    );
  }
}
