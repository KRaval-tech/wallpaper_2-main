// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
//
// part 'localization_event.dart';
// part 'localization_state.dart';
//
// class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
//   LocalizationBloc() : super(LocalizationInitial()) {
//     on<LocalizationEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationState.initial()) {
    on<LoadSavedLocalization>(getLanguage);
    on<LoadLocalization>(changeLanguage);
    //on<ChangeRadioButtonEvent>(_changeRadioButton);
  }

  // _changeRadioButton(
  //     ChangeRadioButtonEvent event,
  //     Emitter<LocalizationState> emit,
  //     ){
  //   emit (state.copyWith(
  //
  //   ));
  // }

  void changeLanguage(LoadLocalization event, Emitter<LocalizationState> emit) {
    // if (event.locale == state.locale) return;
    // saveLocale(event.locale);
    // emit(LocalizationState(event.locale));

    // If language is already selected, don't update
    if (event.locale != state.locale) {
      saveLocale(event.locale);  // Save the selected language
      emit(LocalizationState(event.locale));  // Update the app state
    }
  }

  Future<void> getLanguage(
      LoadSavedLocalization event, Emitter<LocalizationState> emit) async {
    Locale saveLocale = await getLocale();
    emit(LocalizationState(saveLocale));
  }

  Future<void> saveLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', locale.languageCode);
  }

  Future<Locale> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('language') ?? 'en';
    print(languageCode);
    return Locale(languageCode);
  }
}