import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;
  static String _flavorName = "";


  static Future<LocalStorageService> getInstance() async {
    _flavorName = FlavorConfig.instance.name;
    if (_instance == null) {
      _instance = LocalStorageService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  String getString(String key){
    return  _preferences.getString("${_flavorName}_${key}");
  }


  bool getBool(String key){
    return  _preferences.getBool("${_flavorName}_${key}");
  }
  Future<bool> saveBool(String key, bool value){
    return _preferences.setBool("${_flavorName}_${key}", value);

  }



  Future<bool> saveString(String key, String value){
    return _preferences.setString("${_flavorName}_${key}", value);

  }



  Future<bool> remove(String key){
    return _preferences.remove("${_flavorName}_${key}");
  }
  
}


