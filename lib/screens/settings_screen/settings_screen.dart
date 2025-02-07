import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:wallpaper_2/screens/premium_screen/premium_screen.dart';
import '../../core/app_export.dart';
import '../../theme/app_decoration.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_trailing_button.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../choose_language_screen/choose_language.dart';
import '../paywall_screen/paywall_screen.dart';
import 'bloc/settings_bloc.dart';
import 'bloc/settings_event.dart';
import 'bloc/settings_state.dart';

class SettingsPage extends StatefulWidget {

  static Widget builder(BuildContext context){
    return BlocProvider(
      create: (context) => SettingsBloc()..add(LoadSettings()),
      child: SettingsPage(),
    );
  }
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(100.h),
          child: _buildTopAppBar(context),
        ),
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.lightThemeBackground,
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state is SettingsInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SettingsLoaded) {
                return ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return ListTile(
                      leading: Icon(item.icon),
                      title: Text(item.title),
                      onTap: () {
                        // Handle item tap
                      },
                    );
                  },
                );
              } else if (state is SettingsError) {
                return Center(child: Text(state.message));
              }
              return Center(child: Text('No settings available.'));
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Handle action
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildTopAppBar(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 10.h),
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ChooseLanguageScreen()));
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
              // AppbarTrailingButton(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       PageRouteBuilder(
              //         transitionDuration: Duration(milliseconds: 500), // Animation duration
              //         reverseTransitionDuration: Duration(milliseconds: 300), // Reverse animation
              //         pageBuilder: (context, animation, secondaryAnimation) => PaywallScreen(),
              //         transitionsBuilder: (context, animation, secondaryAnimation, child) {
              //           const begin = Offset(0, 1); // Start from bottom
              //           const end = Offset(0, 0); // End at the current position
              //           const curve = Curves.easeInOut; // Animation curve
              //           var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              //           var offsetAnimation = animation.drive(tween);
              //
              //           return SlideTransition(
              //             position: offsetAnimation,
              //             child: child,
              //           );
              //         },
              //       ),
              //     );
              //   },
              // ),
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
              S.current.lbl_settings,
              style: theme.textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
