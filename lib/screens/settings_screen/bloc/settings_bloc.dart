import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<LoadSettings>((event, emit) async {
      try {
        // Mock settings data
        final settings = [
          SettingItem(icon: Icons.privacy_tip, title: 'Privacy'),
          SettingItem(icon: Icons.policy, title: 'Policy'),
          SettingItem(icon: Icons.restore, title: 'Restore Purchase'),
          SettingItem(icon: Icons.info, title: 'About'),
        ];
        await Future.delayed(Duration(milliseconds: 500)); // Simulate loading
        emit(SettingsLoaded(settings));
      } catch (_) {
        emit(SettingsError('Failed to load settings'));
      }
    });
  }
}

class SettingItem {
  final IconData icon;
  final String title;

  SettingItem({required this.icon, required this.title});
}
