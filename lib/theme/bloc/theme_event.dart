part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable{
  @override
  List<Object?> get props => [];//throw UnimplementedError();
}

class ThemeChangeEvent extends ThemeEvent{
  // ThemeChangeEvent({required this.themeType}) : super(){
  //   PrefUtils().setThemeData(themeType);
  // }

  final ThemeType themeType;

  ThemeChangeEvent({required this.themeType});

  @override
  List<Object?> get props => [themeType];
}

