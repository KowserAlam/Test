
import 'package:get/route_manager.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_service.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:jobxprss_company/main_app/root.dart';
import 'package:jobxprss_company/main_app/util/locator.dart';
import 'package:jobxprss_company/main_app/views/widgets/restart_widget.dart';
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
  signOut() {
    AuthService.getInstance().then((value) => value.removeUser()).then((value) {
      locator<RestartNotifier>().restartApp();
      Get.offAll(Root());
    });
  }

}
