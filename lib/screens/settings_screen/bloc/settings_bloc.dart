import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../choose_language_screen/choose_language.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  //final BuildContext context; // Store context for navigation
  SettingsBloc() : super(SettingsInitial()) {
    on<LoadSettings>((event, emit) async {
      //if(state is! SettingsLoaded){
      try {
        // Mock settings data
        final settings = [
          SettingItem(
            iconPath: 'assets/setting_svg/terms.svg',
            title: 'Terms & Conditions',
            onTap: () {
              print('Terms & Conditions Clicked');
              // Navigate to Terms screen if available
            },
          ),
          SettingItem(
            iconPath: 'assets/setting_svg/privacy.svg',
            title: 'Privacy Policy',
            onTap: () {
              print('Privacy Policy Clicked');
              // Navigate to Privacy Policy screen
            },
          ),
          SettingItem(
            iconPath: 'assets/setting_svg/restore.svg',
            title: 'Restore Purchase',
            onTap: () {
              print('Restore Purchase Clicked');
              // Implement Restore Purchase functionality
            },
          ),
          SettingItem(
            iconPath: 'assets/setting_svg/about.svg',
            title: 'About',
            onTap: () {
              print('About Clicked');
              // Navigate to About screen
            },
          ),
          SettingItem(
            iconPath: 'assets/setting_svg/language.svg',
            title: 'Language',
            onTap: () {
              print('Language Clicked');
              // Navigate to language selection screen
              //emit(NavigateToLanguage()); // Emit new state instead of direct navigation
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ChooseLanguageScreen()));
            },
          ),
        ];
        await Future.delayed(Duration(milliseconds: 500)); // Simulate loading
        emit(SettingsLoaded(settings));
      } catch (_) {
        emit(SettingsError('Failed to load settings'));
      }
      //}
    });
    // on<NavigateToLanguageScreen>((event, emit) {
    //   emit(NavigateToLanguage()); // Emit new state to navigate to language selection screen
    // });
  }
}

class SettingItem {
  final String iconPath;
  final String title;
  final VoidCallback onTap; // Function to handle tap events

  SettingItem({required this.iconPath, required this.title, required this.onTap});
}
