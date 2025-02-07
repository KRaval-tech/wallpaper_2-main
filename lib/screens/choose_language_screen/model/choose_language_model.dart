import '../../../core/app_export.dart';

class LanguageModel {
  String language;
  //String subLanguage;
  String languageCode;
  LanguageModel({
    required this.language,
    //required this.subLanguage,
    required this.languageCode,
  });
}

List<LanguageModel> get languageModel => [
  LanguageModel(
    language: S.current.lbl,
    languageCode: 'hi',
  ),
  LanguageModel(
    language: S.current.lbl2,
    languageCode: 'mr',
  ),
  LanguageModel(
    language: S.current.lbl3,
    languageCode: 'gu',
  ),
  LanguageModel(
    language: S.current.lbl_english,
    languageCode: 'en',
  ),
  LanguageModel(
    language: S.current.lbl4,
    languageCode: 'ur',
  ),
  LanguageModel(
    language: S.current.lbl5,
    languageCode: 'bn',
  ),
  LanguageModel(
    language: S.current.lbl6,
    languageCode: 'lo',
  ),

];

// List<String> languages = [
//   'عربي',
//   'dansk',
//   'Nederlands',
//   'English',
//   'Français',
//   'Deutsch',
//   'Ελληνικά',
//   'हिंदी',
//   'bahasa Indonesia',
//   'Italiano',
//   '日本',
//   '한국인',
//   'Norsk Bokmal',
//   'Polski',
//   'Português',
//   'Русский',
//   '简体中文',
//   'Español',
//   'แบบไทย',
//   'Türkçe',
//   'Tiếng Việt',
// ];
// List<String> subLanguage = [
//   'Arabic',
//   'Danish',
//   'Dutch',
//   'English',
//   'French',
//   'German',
//   'Greek',
//   'Hindi',
//   'Indonesian',
//   'Italian',
//   'Japanese',
//   'Korean',
//   'Norwegian Bokmal',
//   'Polish',
//   'Portuguese',
//   'Russian',
//   'Simplified Chinese',
//   'Spanish',
//   'Thai',
//   'Turkish',
//   'Vietnamese',
// ];
// List languageCode = [
//   'ar',
//   'da',
//   'nl',
//   'en',
//   'fr',
//   'de',
//   'el',
//   'hi',
//   'id',
//   'it',
//   'ja',
//   'ko',
//   'nb',
//   'pl',
//   'pt',
//   'ru',
//   'zh',
//   'es',
//   'th',
//   'tr',
//   'vi',
// ];