import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_2/screens/categoriesDetails/bloc/category_detail_bloc.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_trailing_button.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../FullScreenView/fullwallpaper_view.dart';
import '../paywall_screen/paywall_screen.dart';
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
    Key? key,
    required this.title,
  }) : super(key: key);

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
          _buildTopAppBar(context), // Custom AppBar added here
          Expanded(
            child: BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
              builder: (context, state) {
                if (state is CategoryDetailLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CategoryDetailLoaded) {
                  final allWallpapers = [...state.wallpapers, ...state.wallpaper2]; // Dono lists merge
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 107.h / 216.h,
                    ),
                    //itemCount: state.wallpapers.length,
                    itemCount: allWallpapers.length,
                    itemBuilder: (context, index) {
                      //final wallpaper = state.wallpapers[index];
                      final wallpaper = allWallpapers[index];
                      return GestureDetector(
                        onTap: () {
                          final isPremium = (index + 1) % 4 == 0; // Determine if the wallpaper is premium
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenWallpaperPage(
                                //wallpapers: state.wallpapers, // Pass all wallpapers
                                wallpapers: allWallpapers,
                                initialIndex: index, // Pass the tapped wallpaper index
                                isPremium: isPremium,
                              ),
                            ),
                          );
                          // If the wallpaper is premium, delay the dialog to ensure the page is rendered first
                          // if (isPremium) {
                          //   Future.delayed(Duration(milliseconds: 200), () {
                          //     showDialog(
                          //       context: context,
                          //       barrierDismissible: false, // Prevent dismissing without action
                          //       builder: (context) {
                          //         return AlertDialog(
                          //           title: Text("Premium Wallpaper"),
                          //           content: Text("Unlock premium wallpapers by upgrading to the premium plan."),
                          //           actions: [
                          //             TextButton(
                          //               onPressed: () {
                          //                 Navigator.pop(context); // Close the dialog
                          //               },
                          //               child: Text("Cancel"),
                          //             ),
                          //             ElevatedButton(
                          //               onPressed: () {
                          //                 Navigator.pop(context); // Close the dialog
                          //                 Navigator.push(
                          //                   context,
                          //                   MaterialPageRoute(
                          //                     builder: (context) => PaywallScreen(), // Navigate to the paywall screen
                          //                   ),
                          //                 );
                          //               },
                          //               child: Text("Go Premium"),
                          //             ),
                          //           ],
                          //         );
                          //       },
                          //     );
                          //   });
                          // }
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                  image: NetworkImage(wallpaper["download_url"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if ((index + 1) % 4 == 0)
                              Positioned(
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgPremium,
                                  height: 26.h,
                                  width: 26.h,
                                ),
                                //Icon(Icons.workspace_premium,color: Colors.amber,),
                                top: 5.h,
                                left: 76.h,
                              ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is CategoryDetailError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text('No wallpapers available.'));
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
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
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
            print("AppbarTrailingButton tapped!");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PaywallScreen()),
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