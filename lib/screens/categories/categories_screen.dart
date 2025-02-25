import 'package:flutter/material.dart';
import 'package:wallpaper_2/core/app_export.dart';
//import 'package:wallpaper_2/screens/premium_screen/premium_screen.dart';
//import 'package:wallpaper_2/core/utils/progress_dialog.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_trailing_button.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../categoriesDetails/category_detail_screen.dart';
//import '../choose_language_screen/choose_language.dart';
import '../paywall_screen/paywall_screen.dart';
import 'bloc/categories_bloc.dart';
import 'bloc/categories_event.dart';
import 'bloc/categories_state.dart';


class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});


  static Widget builder(BuildContext context){
    return BlocProvider(
        create: (context) => CategoriesBloc()..add(FetchCategories()),
      child: CategoriesPage(),
    );
  }

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(110.h),
            child: _buildTopAppBar(context),
        ),
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.lightThemeBackground,
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is CategoriesLoaded) {
                return GridView.builder(
                  padding: EdgeInsets.all(16.h),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2,
                  ),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    return GestureDetector(
                      onTap: () {
                        // Handle category tap
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryDetailScreen(
                              title: category.name, // Pass the category title
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(category.image),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), // Black color with 0.5 opacity
                              BlendMode.darken,             // Blend mode to darken the image
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          category.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.fSize,
                            fontWeight: FontWeight.bold,
                            shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is CategoriesError) {
                return Center(child: Text(state.message));
              }
              return Center(child: Text('No Categories Available'));
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
              onTap: () {
                // Handle back button tap
               // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ChooseLanguageScreen()));
              },
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
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Text(
              S.current.lbl_categories,
              style: theme.textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
