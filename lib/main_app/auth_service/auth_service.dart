import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_user_model.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:jobxprss_company/main_app/resource/json_keys.dart';
import 'package:jobxprss_company/main_app/util/local_storage.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/token_refresh_scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static AuthService _instance;
  static LocalStorageService _localStorageService;

  static Future<AuthService> getInstance() async {
    if (_instance == null) {
      _instance = AuthService();
    }
    if (_localStorageService == null) {
      _localStorageService = await LocalStorageService.getInstance();
    }
    return _instance;
  }

  AuthUserModel getUser() {
    var userMap = _localStorageService.getString(JsonKeys.user);
//    debugPrint("UserMap: ${userMap}");
    if (userMap == null) {
      return null;
    }
//    return AuthUserModel.fromJson(json.decode(userMap));
    return AuthUserModel.fromJsonLocal(json.decode(userMap));
  }


  Future<bool> saveUser(Map<String, dynamic> data) {
    var encodedData = json.encode(data);
    return _localStorageService.saveString(JsonKeys.user, encodedData);
  }

  Future<bool> removeUser() {
    _instance = AuthService();
     _localStorageService.remove(JsonKeys.company);
    return _localStorageService.remove(JsonKeys.user);
  }

  Future<bool> _setJwt(String jwt) async {
    var user = _instance.getUser();
    user.accessToken = jwt;
    var data = user.toJson();
//    debugPrint("_setJwt ${data}");
    return _instance.saveUser(data);
  }

  String _getAssessToken()  {
    var user = _instance.getUser();
    if (user?.userId == null || user?.cId == null) {
      return null;
    }
    return user.accessToken;
  }

  String _getRefreshToken() {
    var user = _instance.getUser();
    if (user == null) {
      return null;
    }
    return user.refresh;
  }

  Duration getRefreshInterval()  {
    DateTime expTime;
    String token = _instance. _getAssessToken();
    if (token != null) {
      var payload = Jwt.parseJwt(token);
      debugPrint(payload.toString());
      if (payload['exp'] != null) {
        expTime = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
//        var isValid = DateTime.now().isBefore(expTime);
        return expTime.difference(DateTime.now());
      }

      return null;
    } else {
      return null;
    }
  }
  bool isAccessTokenValid()  {
    DateTime expTime;
    String token = _instance. _getAssessToken();
    if (token != null) {
      var payload = Jwt.parseJwt(token);
      debugPrint(payload.toString());
      if (payload['exp'] != null) {
        expTime = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
        var isValid = DateTime.now().isBefore(expTime);
        logger.i(expTime.difference(DateTime.now()).inMinutes);
        logger.i(expTime);
        logger.i(isValid);
        return isValid;
      }

      return false;
    } else {
      return false;
    }
  }

  bool _isRefreshTokenValid()  {
    DateTime expTime;
    String token =  _getRefreshToken();
    if (token != null) {
      var payload = Jwt.parseJwt(token);
      debugPrint(payload.toString());
      if (payload['exp'] != null) {
        expTime = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
        var isValid = DateTime.now().isBefore(expTime);
        logger.i(expTime.difference(DateTime.now()).inMinutes);
        logger.i(expTime);
        logger.i(isValid);
        return isValid;
      }

      return false;
    } else {
      return false;
    }
  }

  Future<bool> refreshToken() async {
    if (await _isRefreshTokenValid()) {
      try {
        var baseUrl = FlavorConfig.instance.values.baseUrl;
        String rfToken = _instance._getRefreshToken();
        var body = {"refresh": rfToken};
        logger.i(body);
        var res = await http.post("${baseUrl}${Urls.jwtRefreshUrl}",body: body);
        logger.i(res.statusCode);
        logger.i(res.body);
        if (res.statusCode == 200) {
          var data = json.decode(res.body);
          debugPrint("Token refreshed: {${res.body}");

          return _instance._setJwt(data['access']).then((value) {
            return value ? true : false;
          });
        } else {
          return false;
        }
      } catch (e) {
        logger.e(e);
        return false;
      }
    } else {
      return false;
    }
  }

//  Future<bool> checkIfLoggedIn() async {
//    SharedPreferences localStorage = await SharedPreferences.getInstance();
//    var token = localStorage.getString('token');
//    if (token != null)
//      return true;
//    else
//      return false;
//  }

}
