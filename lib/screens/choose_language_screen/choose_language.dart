import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_2/Ads/native_ad.dart';
import 'package:wallpaper_2/screens/choose_language_screen/bloc/localization_bloc.dart';
import 'package:wallpaper_2/screens/choose_language_screen/model/choose_language_model.dart';
import 'package:wallpaper_2/widgets/app_bar/appbar_title.dart';
import 'package:wallpaper_2/widgets/app_bar/custom_app_bar.dart';
import 'package:wallpaper_2/widgets/custom_bottom_bar.dart';
import 'package:wallpaper_2/widgets/custom_elevated_button.dart';
import 'package:wallpaper_2/widgets/custom_radio_button.dart';

import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../home_one_screen/home_one_screen.dart';


class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});

  static Widget builder(BuildContext context){
    return BlocProvider<LocalizationBloc>(
        create: (context) => LocalizationBloc(
        ),
      child: ChooseLanguageScreen(),
    );
  }


  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

// class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
//
//    //late SharedPreferences _prefs;
//   bool _isLoading = false; // Variable to track loading state
//   bool isFirstLaunch = false;
//   late String selectedLanguage; // Keep track of selected language locally
//
//   @override
//   void initState() {
//     super.initState();
//     _checkFirstLaunch();
//     selectedLanguage = BlocProvider.of<LocalizationBloc>(context).state.locale.languageCode;
//     //_initializePreferences();
//   }
//
//
//   Future<void> _checkFirstLaunch() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
//
//     if (isFirstLaunch) {
//       await prefs.setBool('isFirstLaunch', false); // Pehli baar hai, ab future me false hoga
//     }
//   }
//
//   // Function to simulate some delay before navigating
//   Future<void> _onChooseButtonPressed(BuildContext context) async {
//     setState(() {
//       _isLoading = true; // Show the loader
//     });
//
//     // Proceed to change the language once the "Choose" button is pressed
//     BlocProvider.of<LocalizationBloc>(context).add(
//       LoadLocalization(Locale(selectedLanguage)),
//     );
//     // Simulate some delay (this can be replaced with actual async logic if needed)
//     //await Future.delayed(Duration(seconds: 1)); // You can adjust the duration as needed
//
//     //Save the selected language in SharedPreferences
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     // await prefs.setString('selected_language', locale.languageCode);
//     //
//     // Proceed to the next screen after delay
//     Navigator.pushNamed(context, AppRoutes.custombottombar);
//
//     setState(() {
//       _isLoading = false; // Hide the loader
//     });
//   }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(context),
//       body: SafeArea(
//         top: false,
//         child: SizedBox(
//           width: double.maxFinite,
//           child: SingleChildScrollView(
//             child: SizedBox(
//               width: double.maxFinite,
//               child: Column(
//                 children: [
//                   _buildLanguageSelectionRow(context),
//                   SizedBox(height: 20.h),
//                   _buildLanguageOptionsColumn(context),
//                   SizedBox(height: 15.h),
//                   BlocBuilder<LocalizationBloc, LocalizationState>(
//                     builder: (context, state) {
//                       // Enable the button only if a language is selected
//                       //bool isButtonEnabled = state.locale.languageCode.isNotEmpty;
//                       bool isButtonEnabled = selectedLanguage.isNotEmpty;
//
//                       return CustomElevatedButton(
//                         height: 44.h,
//                         text: S.current.lbl_choose,
//                         margin: EdgeInsets.symmetric(horizontal: 50.h),
//                         buttonStyle: CustomButtonStyles.none,
//                         decoration: CustomButtonStyles.gradientBlueToBlueDecoration,
//                         buttonTextStyle: CustomTextStyles.titleMediumBold,
//                         onPressed: isButtonEnabled
//                             ? () {
//                           _onChooseButtonPressed(context);
//                         }
//                             : null,
//                       );
//                     },
//                   ),
//                   SizedBox(height: 15.h),
//                   // _buildNativeAd(),
//                   ResponsiveNativeAd(),
//                   SizedBox(height: 8.h),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return CustomAppBar(
//       actions: [
//         AppbarTitle(
//           text: S.current.lbl_skip,
//           margin: EdgeInsets.only(right: 23.h,top: 23.h),
//           onTap: () {
//             if (isFirstLaunch) {
//               // Pehli baar open ho rahi hai, to English set karo
//               BlocProvider.of<LocalizationBloc>(context).add(
//                 LoadLocalization(Locale('en')),
//               );
//             }
//
//             // Skip should not change the language, only navigate
//             Navigator.pushNamed(context, AppRoutes.custombottombar);
//           },
//         ),
//       ],
//     );
//   }
//
//
//   Widget _buildLanguageSelectionRow(BuildContext context){
//     return Container(
//       width: double.maxFinite,
//       margin: EdgeInsets.symmetric(horizontal: 32.h),
//       child: Row(
//         children: [
//           CustomImageView(
//             imagePath: ImageConstant.imgGoogleTranslateLogo,
//             height: 47.h,
//             width: 47.h,
//           ),
//           Padding(
//               padding: EdgeInsets.only(left: 28.h),
//             child: Text(
//               S.current.msg_help_us_know_your_preferred,
//               style: CustomTextStyles.titleMediumBlack900,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLanguageOptionsColumn(BuildContext context) {
//     var groupValue = context.read<LocalizationBloc>().state.locale.languageCode;
//
//     return Container(
//       width: double.maxFinite,
//       padding: EdgeInsets.symmetric(horizontal: 26.h, vertical: 16.h),
//       decoration: AppDecoration.fillOnPrimary.copyWith(
//         borderRadius: BorderRadiusStyle.roundedBorder14,
//       ),
//       child: BlocConsumer<LocalizationBloc, LocalizationState>(
//         listener: (context, state) {
//           groupValue = state.locale.languageCode;
//         },
//         builder: (context, state) {
//           return GridView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 10.h,
//               mainAxisSpacing: 10.h,
//               childAspectRatio: 3,
//             ),
//             itemCount: languageModel.length + 1, // Add 1 for the "More>" button
//             itemBuilder: (context, index) {
//               if (index == languageModel.length) {
//                 // "More>" button at the end of the grid
//                 return GestureDetector(
//                   onTap: () {
//                     // Add your onTap functionality for the "More>" button
//                     print("More button tapped");
//                     // You could navigate to a new screen or show more options
//                   },
//                   child: Container(
//                     padding: EdgeInsets.fromLTRB(18.h, 12.h, 30.h, 12.h),
//                     decoration: RadioStyleHelper.outlineGray, // Same style as other items
//                     child: Center(
//                       child: Text(
//                         "More>", // Text for the "More>" button
//                         style: theme.textTheme.bodyLarge,
//                       ),
//                     ),
//                   ),
//                 );
//               } else {
//                 var item = languageModel[index];
//                 //bool? isSelected = item.languageCode == groupValue;
//                 bool isSelected = item.languageCode == selectedLanguage;
//                 return CustomRadioButton(
//                   value: item.languageCode,
//                   groupValue: groupValue,
//                   padding: EdgeInsets.fromLTRB(18.h, 12.h, 30.h, 12.h),
//                   decoration: isSelected
//                       ? RadioStyleHelper.fillLightBlueF
//                       : RadioStyleHelper.outlineGray,
//                   onChange: (value) {
//                     // BlocProvider.of<LocalizationBloc>(context).add(
//                     //     LoadLocalization(Locale(item.languageCode)));
//                     setState(() {
//                       selectedLanguage = value;
//                     });
//                   },
//                   title: item.language,
//                 );
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  bool _isLoading = false;
  bool isFirstLaunch = false;
  String selectedLanguage = 'en';  // Default language is English

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
    _loadCurrentLanguage();
  }

  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
    }
  }

  Future<void> _loadCurrentLanguage() async {
    // Load the saved language from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('language') ?? 'en';
    });
  }

  Future<void> _onChooseButtonPressed(BuildContext context) async {
    setState(() {
      _isLoading = true;  // Show loading indicator
    });

    // Change language and navigate
    BlocProvider.of<LocalizationBloc>(context).add(
      LoadLocalization(Locale(selectedLanguage)),
    );

    Navigator.pushNamed(context, AppRoutes.custombottombar);  // Navigate to the next screen

    setState(() {
      _isLoading = false;  // Hide loading indicator
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  _buildLanguageSelectionRow(context),
                  SizedBox(height: 20.h),
                  _buildLanguageOptionsColumn(context),
                  SizedBox(height: 15.h),
                  BlocBuilder<LocalizationBloc, LocalizationState>(
                    builder: (context, state) {
                      bool isButtonEnabled = state.locale.languageCode.isNotEmpty;

                      return CustomElevatedButton(
                        height: 44.h,
                        text: S.current.lbl_choose,
                        margin: EdgeInsets.symmetric(horizontal: 50.h),
                        buttonStyle: CustomButtonStyles.none,
                        decoration: CustomButtonStyles.gradientBlueToBlueDecoration,
                        buttonTextStyle: CustomTextStyles.titleMediumBold,
                        onPressed: isButtonEnabled
                            ? () {
                          _onChooseButtonPressed(context);
                        }
                            : null,
                      );
                    },
                  ),
                  SizedBox(height: 15.h),
                  ResponsiveNativeAd(),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      actions: [
        AppbarTitle(
          text: S.current.lbl_skip,
          margin: EdgeInsets.only(right: 23.h, top: 23.h),
          onTap: () {
            if (isFirstLaunch) {
              // Default to English if first launch
              BlocProvider.of<LocalizationBloc>(context).add(
                LoadLocalization(Locale('en')),
              );
            }

            Navigator.pushNamed(context, AppRoutes.custombottombar);  // Skip navigation
          },
        ),
      ],
    );
  }

  Widget _buildLanguageSelectionRow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 32.h),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgGoogleTranslateLogo,
            height: 47.h,
            width: 47.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.h),
            child: Text(
              S.current.msg_help_us_know_your_preferred,
              style: CustomTextStyles.titleMediumBlack900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOptionsColumn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 26.h, vertical: 16.h),
      decoration: AppDecoration.fillOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder14,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.h,
          mainAxisSpacing: 10.h,
          childAspectRatio: 3,
        ),
        itemCount: languageModel.length + 1,
        itemBuilder: (context, index) {
          if (index == languageModel.length) {
            return GestureDetector(
              onTap: () {
                print("More button tapped");
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(18.h, 12.h, 30.h, 12.h),
                decoration: RadioStyleHelper.outlineGray,
                child: Center(
                  child: Text(
                    "More>",
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ),
            );
          } else {
            var item = languageModel[index];
            bool isSelected = item.languageCode == selectedLanguage;

            return CustomRadioButton(
              value: item.languageCode,
              groupValue: selectedLanguage,
              padding: EdgeInsets.fromLTRB(18.h, 12.h, 30.h, 12.h),
              decoration: isSelected
                  ? RadioStyleHelper.fillLightBlueF
                  : RadioStyleHelper.outlineGray,
              onChange: (value) {
                setState(() {
                  selectedLanguage = value;
                });
              },
              title: item.language,
            );
          }
        },
      ),
    );
  }
}

