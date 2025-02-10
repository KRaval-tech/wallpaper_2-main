import 'package:equatable/equatable.dart';
import 'package:wallpaper_2/screens/settings_screen/bloc/settings_bloc.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final List<SettingItem> items;

  SettingsLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class SettingsError extends SettingsState {
  final String message;

  SettingsError(this.message);

  @override
  List<Object> get props => [message];
}


//class NavigateToLanguage extends SettingsState {} // New State for Navigation