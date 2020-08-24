import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_service.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_user_model.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:jobxprss_company/main_app/resource/json_keys.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/local_storage.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:jobxprss_company/main_app/util/validator.dart';

class SigninViewModel with ChangeNotifier {
  bool _isObscurePassword = true;
  String _email = "";
  String _password = "";
  bool _isBusyLogin = false;
  bool _isFromSuccessfulSignUp = false;
  String _errorTextEmail;
  String _errorTextPassword;
  String _errorMessage;

  String get errorMessage => _errorMessage;

  String get errorTextEmail => _errorTextEmail;

  set errorTextEmail(String value) {
    _errorTextEmail = value;
  }

  String get errorTextPassword => _errorTextPassword;

  set errorTextPassword(String value) {
    _errorTextPassword = value;
  }

  bool get isFromSuccessfulSignUp => _isFromSuccessfulSignUp;

  set isFromSuccessfulSignUp(bool value) {
    _isFromSuccessfulSignUp = value;
    notifyListeners();
  }

  bool get isObscurePassword => _isObscurePassword;

  set isObscurePassword(bool value) {
    _isObscurePassword = value;
    notifyListeners();
  }

  bool get isBusyLogin => _isBusyLogin;

  set isBusyLogin(bool value) {
    _isBusyLogin = value;
    notifyListeners();
  }

  String get password => _password;

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  clearMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  bool validate() {
    validateEmailLocal(_email);
    validatePasswordLocal(_password);
    return errorTextEmail == null && errorTextPassword == null;
  }

  validateEmailLocal(String val) {
    errorTextEmail = Validator().validateEmail(val?.trim());
    _email = val;
    _errorMessage = null;
    notifyListeners();
  }

  validatePasswordLocal(String val) {
    errorTextPassword = Validator().validateEmptyPassword(val);
    _password = val?.trim();
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> loginWithEmailAndPassword() async {
    isBusyLogin = true;
    var body = {JsonKeys.email: email?.trim(), JsonKeys.password: password?.trim()};

    try {
      var baseUrl = FlavorConfig.instance.values.baseUrl;
      var url = "$baseUrl${Urls.signInUrl}";
      http.Response response = await http.post(url, body: body);

      logger.i(response.body);
      logger.i(response.statusCode);

      isBusyLogin = false;
      if (response.statusCode == 200) {
        Map<String, dynamic> decodedJson = jsonDecode(utf8.decode(response.bodyBytes));
        _saveAuthData(decodedJson);
        clearMessage();
        return true;
      } else {
        var decodedJson = jsonDecode(response.body);
        var m = decodedJson['detail']?.toString() ?? "";
        _errorMessage = m;
        notifyListeners();
        BotToast.showText(text: m);
        return false;
      }
    } on SocketException catch (e) {
      isBusyLogin = false;
      BotToast.showText(text: StringResources.couldNotReachServer);
      _errorMessage = StringResources.couldNotReachServer;
      notifyListeners();
      logger.e(e);
      return false;
    } catch (e) {
      logger.e(e);
      isBusyLogin = false;
      BotToast.showText(text: StringResources.somethingIsWrong);
      return false;
    }
  }

  resetState() {
    _isObscurePassword = true;
    _email = "";
    _password = "";
    _isBusyLogin = false;
    _isFromSuccessfulSignUp = false;
    _errorTextEmail = null;
    _errorTextEmail = null;
    _errorMessage = null;
  }

  _saveAuthData(Map<String, dynamic> data) async {
    var authModel = AuthUserModel.fromJson(data);
    var storage = await LocalStorageService.getInstance();
    var auth = await AuthService.getInstance();
    var company = Company.fromJson(data['company']);
    storage.saveString(JsonKeys.company, json.encode(company.toJson()));
    return auth.saveUser(authModel.toJson());
  }

  signOut() async {
    var authService = await AuthService.getInstance();
    authService.removeUser();
  }
}
