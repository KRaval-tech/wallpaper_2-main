// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:wallpaper_2/core/app_export.dart';
// part 'theme_event.dart';
// part 'theme_state.dart';
//
// class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{
//   ThemeBloc(ThemeState initialState) : super(initialState){
//     on<ThemeChangeEvent>(_changeTheme);
//   }
//
//   _changeTheme(
//       ThemeChangeEvent event,
//       Emitter<ThemeState> emit,
//       ) async{
//     emit(state.copyWith(themeType: event.themeType));
//   }
// }
//


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wallpaper_2/core/app_export.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeType: _getInitialTheme())) {
    on<ThemeChangeEvent>(_changeTheme);
  }

  static ThemeType _getInitialTheme() {
    String themeData = PrefUtils().getThemeData();
    // Convert the string to ThemeType
    return themeData == 'dark' ? ThemeType.dark : ThemeType.light;
  }

  void _changeTheme(
      ThemeChangeEvent event,
      Emitter<ThemeState> emit,
      ) {
    emit(state.copyWith(themeType: event.themeType));
    // Save the new theme to SharedPreferences
    PrefUtils().setThemeData(event.themeType == ThemeType.dark ? 'dark' : 'light');
  }
}
