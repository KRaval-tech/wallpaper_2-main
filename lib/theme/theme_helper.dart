import 'package:flutter/material.dart';
import 'package:wallpaper_2/core/app_export.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

class ThemeHelper {
  var _appTheme = PrefUtils().getThemeData();

  Map<String, LightCodeColors> _supportedCustomColor ={
    'lightCode': LightCodeColors()
  };

  Map<String, ColorScheme> _supportedColorScheme ={
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  LightCodeColors _getThemeColors(){
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  ThemeData _getThemeData(){
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.black900.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.h),
          ),
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: colorScheme.onPrimary,
            width: 1.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.h),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateColor.resolveWith((states){
          if(states.contains(WidgetState.selected)){
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: appTheme.blue500,
      ),
      dividerTheme: DividerThemeData(
        thickness: 4,
        space: 4,
        color: appTheme.gray900,
      ),
    );
  }

  LightCodeColors themeColor() => _getThemeColors();

  ThemeData themeData() => _getThemeData();

}

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
    bodyLarge: TextStyle(
      color: appTheme.black900,
      fontSize: 18.fSize,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      color: appTheme.gray90002,
      fontSize: 24.fSize,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w700,
    ),
    labelLarge: TextStyle(
      color: appTheme.gray600,
      fontSize: 12.fSize,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      color: appTheme.gray90002,
      fontSize: 20.fSize,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      color: colorScheme.onPrimary,
      fontSize: 18.fSize,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: appTheme.gray500,
      fontSize: 15.fSize,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w500,
    ),
  );
}

class ColorSchemes{
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFF0065D3),
    secondaryContainer: Color(0XFF45484F),
    onPrimary: Color(0XFFFFFFFF),
    onPrimaryContainer: Color(0XFF292D32),
  );
}

class LightCodeColors {
  Color get amber50047 => Color(0X47FEC714);
  Color get black900 => Color(0XFF000000);

  Color get blue400 => Color(0XFF50AAF9);
  Color get blue500 => Color(0XFF2196F3);
  Color get blue700 => Color(0XFF1972D6);
  Color get blueA200 => Color(0XFF4285F4);

  Color get blueGray500 => Color(0XFF607988);

  Color get cyan700 => Color(0XFF11959A);

  Color get deepOrange400 => Color(0XFFFD7E46);

  Color get gray100 => Color(0XFFF3F4F9);
  Color get gray200 => Color(0XFFEEEEEE);
  Color get gray20001 => Color(0XFFEBEBEB);
  Color get gray300 => Color(0XFFDBDBDB);
  Color get gray30001 => Color(0XFFDCDCDC);
  Color get gray30002 => Color(0XFFE3E3E3);
  Color get gray400 => Color(0XFFB7B7B7);
  Color get gray500 => Color(0XFF959595);
  Color get gray600 => Color(0XFF7E7E82);
  Color get gray800 => Color(0XFF3C3D3E);
  Color get gray900 => Color(0XFF1E1E1E);
  Color get gray90001 => Color(0XFF001E2F);
  Color get gray90002 => Color(0XFF1B1B1F);

  Color get greenA700 => Color(0XFF0BBE62);

  Color get indigo500 => Color(0XFF4352B8);

  Color get lightBlue1004f => Color(0X4FACDAFF);

  Color get orange300 => Color(0XFFFFBC40);

  Color get pinkA200 => Color(0XFFFC4487);

  Color get whiteA700 => Color(0XFFFCFCFF);

  Color get yellow900 => Color(0XFFFA7D2A);
}