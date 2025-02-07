import 'package:flutter/material.dart';
import 'package:wallpaper_2/core/app_export.dart';

import '../generated/l10n.dart';

enum BottomBarEnum {Home, Categories, Premium, Settings}





class CustomBottomBar extends StatefulWidget {
  final Function(BottomBarEnum)? onChanged;
  //final int selectedIndex;
  const CustomBottomBar({super.key,this.onChanged,});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {

  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList =[
    BottomMenuModel(
      icon: ImageConstant.imgNavHome1,
      activeIcon: ImageConstant.imgNavHome,
      title: S.current.lbl_home,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavCategories,
      activeIcon: ImageConstant.imgNavCategories2,
      title: S.current.lbl_categories,
      type: BottomBarEnum.Categories,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavPremium1,
      activeIcon: ImageConstant.imgNavPremium,
      title: S.current.lbl_premium,
      type: BottomBarEnum.Premium,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavSetting,
      activeIcon: ImageConstant.imgNavSetting2,
      title: S.current.lbl_settings,
      type: BottomBarEnum.Settings,

    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: appTheme.gray100,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index){
          return BottomNavigationBarItem(
            icon: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[index].icon,
                  height: 24.h,
                  width: 26.h,
                  //color: Color(0XFF292D32),
                ),
                SizedBox(height: 8.h),
                Text(
                  bottomMenuList[index].title ?? "",
                  style: CustomTextStyles.labelLargeRobotoSecondaryContainer
                      .copyWith(
                    color: Color(0XFF45484F),
                  ),
                ),
              ],
            ),
          ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[index].activeIcon,
                  height: 24.h,
                  width: 26.h,
                  //color: Color(0XFF2196F3),
                ),
                SizedBox(height: 8.h),
                Text(
                  bottomMenuList[index].title ?? "",
                  style: CustomTextStyles.labelLargeRobotoBlue500
                      .copyWith(
                    color: appTheme.blue500,
                  ),
                ),
              ],
            ),
            label: '',
          );
        }),
        onTap: (index){
          setState(() {
            selectedIndex = index;
            widget.onChanged?.call(bottomMenuList[index].type);
          });
        },
      ),
    );
  }
}

class BottomMenuModel {
  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;

  BottomMenuModel(
      {required this.icon,
        required this.activeIcon,
        this.title,
        required this.type});
}

