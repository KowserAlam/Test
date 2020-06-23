
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel with ChangeNotifier {
  SettingsViewModel() {
    initPref();
  }


  initPref() async {
    var preferences = await SharedPreferences.getInstance();
    isDarkModeOn = preferences.getBool(StringResources.isDarkModeOn) ?? false;
  }

  bool _isDarkModeOn = false;

  bool get isDarkModeOn => _isDarkModeOn;

  set isDarkModeOn(bool value) {
    _isDarkModeOn = value;
    notifyListeners();
  }


  void toggleThemeChangeEvent() async{
    isDarkModeOn =  !isDarkModeOn;
    var preferences = await SharedPreferences.getInstance();
    preferences.setBool(StringResources.isDarkModeOn, isDarkModeOn);
  }
}
