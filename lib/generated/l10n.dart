// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `हिंदी`
  String get lbl {
    return Intl.message(
      'हिंदी',
      name: 'lbl',
      desc: '',
      args: [],
    );
  }

  /// `मराठी`
  String get lbl2 {
    return Intl.message(
      'मराठी',
      name: 'lbl2',
      desc: '',
      args: [],
    );
  }

  /// `ગુજરાતી`
  String get lbl3 {
    return Intl.message(
      'ગુજરાતી',
      name: 'lbl3',
      desc: '',
      args: [],
    );
  }

  /// `اردو`
  String get lbl4 {
    return Intl.message(
      'اردو',
      name: 'lbl4',
      desc: '',
      args: [],
    );
  }

  /// `বাংলা`
  String get lbl5 {
    return Intl.message(
      'বাংলা',
      name: 'lbl5',
      desc: '',
      args: [],
    );
  }

  /// `ລີໂອ`
  String get lbl6 {
    return Intl.message(
      'ລີໂອ',
      name: 'lbl6',
      desc: '',
      args: [],
    );
  }

  /// `Best`
  String get lbl_best {
    return Intl.message(
      'Best',
      name: 'lbl_best',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get lbl_categories {
    return Intl.message(
      'Categories',
      name: 'lbl_categories',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get lbl_choose {
    return Intl.message(
      'Choose',
      name: 'lbl_choose',
      desc: '',
      args: [],
    );
  }

  /// `Crono`
  String get lbl_crono {
    return Intl.message(
      'Crono',
      name: 'lbl_crono',
      desc: '',
      args: [],
    );
  }

  /// `Emoji`
  String get lbl_emoji {
    return Intl.message(
      'Emoji',
      name: 'lbl_emoji',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get lbl_english {
    return Intl.message(
      'English',
      name: 'lbl_english',
      desc: '',
      args: [],
    );
  }

  /// `Featured`
  String get lbl_featured {
    return Intl.message(
      'Featured',
      name: 'lbl_featured',
      desc: '',
      args: [],
    );
  }

  /// `Galaxy`
  String get lbl_galaxy {
    return Intl.message(
      'Galaxy',
      name: 'lbl_galaxy',
      desc: '',
      args: [],
    );
  }

  /// `Get a Pro`
  String get lbl_get_a_pro {
    return Intl.message(
      'Get a Pro',
      name: 'lbl_get_a_pro',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get lbl_home {
    return Intl.message(
      'Home',
      name: 'lbl_home',
      desc: '',
      args: [],
    );
  }

  /// `Live Photo`
  String get lbl_live_photo {
    return Intl.message(
      'Live Photo',
      name: 'lbl_live_photo',
      desc: '',
      args: [],
    );
  }

  /// `More >`
  String get lbl_more {
    return Intl.message(
      'More >',
      name: 'lbl_more',
      desc: '',
      args: [],
    );
  }

  /// `People`
  String get lbl_people {
    return Intl.message(
      'People',
      name: 'lbl_people',
      desc: '',
      args: [],
    );
  }

  /// `Photo Shuffle`
  String get lbl_photo_shuffle {
    return Intl.message(
      'Photo Shuffle',
      name: 'lbl_photo_shuffle',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get lbl_color {
    return Intl.message(
      'Color',
      name: 'lbl_color',
      desc: '',
      args: [],
    );
  }

  /// `Astronomy`
  String get lbl_astro {
    return Intl.message(
      'Astronomy',
      name: 'lbl_astro',
      desc: '',
      args: [],
    );
  }

  /// `Weather`
  String get lbl_weather {
    return Intl.message(
      'Weather',
      name: 'lbl_weather',
      desc: '',
      args: [],
    );
  }

  /// `Photos`
  String get lbl_photos {
    return Intl.message(
      'Photos',
      name: 'lbl_photos',
      desc: '',
      args: [],
    );
  }

  /// `Premium`
  String get lbl_premium {
    return Intl.message(
      'Premium',
      name: 'lbl_premium',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get lbl_settings {
    return Intl.message(
      'Setting',
      name: 'lbl_settings',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get lbl_skip {
    return Intl.message(
      'Skip',
      name: 'lbl_skip',
      desc: '',
      args: [],
    );
  }

  /// `Wallpaper`
  String get lbl_wallpaper {
    return Intl.message(
      'Wallpaper',
      name: 'lbl_wallpaper',
      desc: '',
      args: [],
    );
  }

  /// `Help us know your\npreferred Language`
  String get msg_help_us_know_your_preferred {
    return Intl.message(
      'Help us know your\npreferred Language',
      name: 'msg_help_us_know_your_preferred',
      desc: '',
      args: [],
    );
  }

  /// `Suggested Wallpapers`
  String get msg_suggested_wallpapers {
    return Intl.message(
      'Suggested Wallpapers',
      name: 'msg_suggested_wallpapers',
      desc: '',
      args: [],
    );
  }

  /// `Network Error`
  String get msg_network_err {
    return Intl.message(
      'Network Error',
      name: 'msg_network_err',
      desc: '',
      args: [],
    );
  }

  /// `Something Went Wrong!`
  String get msg_something_went_wrong {
    return Intl.message(
      'Something Went Wrong!',
      name: 'msg_something_went_wrong',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'gu'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'lo'),
      Locale.fromSubtags(languageCode: 'mr'),
      Locale.fromSubtags(languageCode: 'ur'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
