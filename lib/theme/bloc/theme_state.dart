part of 'theme_bloc.dart';

enum ThemeType {light,dark}

class ThemeState extends Equatable{
  ThemeState({required this.themeType});

  final ThemeType themeType;

  @override
  List<Object?> get props => [themeType];
  ThemeState copyWith({ThemeType? themeType}){
    return ThemeState(themeType: themeType ?? this.themeType);
  }
}