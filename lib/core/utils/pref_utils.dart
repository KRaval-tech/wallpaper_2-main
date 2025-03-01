import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_2/core/app_export.dart';

class PrefUtils {
  PrefUtils(){
    SharedPreferences.getInstance().then((value){
      _sharedPreferences = value;
    });
  }

  static SharedPreferences? _sharedPreferences;

  Future<void> init() async{
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print("ShardedPreference Initialized");
  }

  void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  Future<void> setThemeData(String value){
    return _sharedPreferences!.setString('themeData', value);
  }

  String getThemeData(){
    try{
      return _sharedPreferences!.getString("themeData")!;
    } catch(e){
      return 'primary';
    }
  }

}