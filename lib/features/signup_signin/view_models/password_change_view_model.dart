import 'dart:convert';
import 'dart:io';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:jobxprss_company/method_extension.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_service.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/validator.dart';

class PasswordChangeViewModel with ChangeNotifier {
  String _oldPassword = "";
  String _newPassword = "";
  String _confirmNewPassword = "";

  String _errorTextOldPassword;
  String _errorTextNewPassword;
  String _errorTextConfirmPassword;
  bool _isBusy = false;
  bool _isObscurePasswordOld = true;
  bool _isObscurePasswordNew = true;
  bool _isObscurePasswordConfirm = true;


  bool get isObscurePasswordOld => _isObscurePasswordOld;

  set isObscurePasswordOld(bool value) {
    _isObscurePasswordOld = value;
    notifyListeners();
  }



  bool get isObscurePasswordNew => _isObscurePasswordNew;

  set isObscurePasswordNew(bool value) {
    _isObscurePasswordNew = value;
    notifyListeners();
  }



  bool get isObscurePasswordConfirm => _isObscurePasswordConfirm;

  set isObscurePasswordConfirm(bool value) {
    _isObscurePasswordConfirm = value;
    notifyListeners();
  }

  bool get isBusy => _isBusy;

  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  String get errorTextOldPassword => _errorTextOldPassword;

  set errorTextOldPassword(String value) {
    _errorTextOldPassword = value;
  }

  String get errorTextNewPassword => _errorTextNewPassword;

  set errorTextNewPassword(String value) {
    _errorTextNewPassword = value;
  }

  String get errorTextConfirmPassword => _errorTextConfirmPassword;

  set errorTextConfirmPassword(String value) {
    _errorTextConfirmPassword = value;
  }

  bool get allowSubmitButton {
    bool isNoErrors = _errorTextConfirmPassword == null &&
        _errorTextNewPassword == null &&
        _errorTextOldPassword == null;

    bool isNoEmptyFields = _newPassword.isNotEmptyOrNotNull &&
        _oldPassword.isNotEmptyOrNotNull &&
        _confirmNewPassword.isNotEmptyOrNotNull;

    return isNoEmptyFields & isNoErrors;
  }

  bool validate() {
    onChangeOldPassword(_oldPassword);
    onChangeNewPassword(_newPassword);
    onChangeConfirmPassword(_confirmNewPassword);

    return _errorTextNewPassword == null &&
        _errorTextConfirmPassword == null &&
        _errorTextOldPassword == null;
  }

  onChangeOldPassword(String val) {
    _oldPassword = val;
    _errorTextOldPassword = Validator().validateEmptyPassword(val);
    notifyListeners();
  }

  onChangeNewPassword(String val) {
    _newPassword = val;
    _errorTextNewPassword = Validator().validatePassword(val);

    if (_confirmNewPassword.isNotEmptyOrNotNull) {
      onChangeConfirmPassword(_confirmNewPassword);
    }
    notifyListeners();
  }

  onChangeConfirmPassword(String val) {
    _confirmNewPassword = val;
    _errorTextConfirmPassword =
        Validator().validateConfirmPassword(_newPassword, val);

    notifyListeners();
  }


  resetState(){
    _isObscurePasswordOld = true;
    _isObscurePasswordNew = true;
    _isObscurePasswordConfirm = true;
     _oldPassword = "";
     _newPassword = "";
     _confirmNewPassword = "";
     _errorTextOldPassword;
     _errorTextNewPassword;
     _errorTextConfirmPassword;
     _isBusy = false;
  }

  Future<bool> changePassword() async {
    bool isValid = validate();
    logger.i(isValid);

    if (isValid) {
      isBusy = true;
      var userId = await AuthService.getInstance()
          .then((value) => value.getUser().userId);
      var body = {
        "user_id": userId,
        "old_password": _oldPassword,
        "new_password": _newPassword
      };



      try {
        var res = await ApiClient().postRequest(Urls.passwordChangeUrl, body);

        logger.i(res.statusCode);
        logger.i(res.body);
        isBusy = false;
        var data = json.decode(res.body);
        logger.i(data['status']);
        if (data['status'] == "success") {
          BotToast.showText(text: StringResources.passwordChangeSuccessful);
          resetState();
          return true;
        } else {
          var data = json.decode(res.body);
          var message = data['message'];
          _errorTextOldPassword = message;
          notifyListeners();
          logger.i("Unable to change password");
          return false;
        }
//        if (res.statusCode == 200) {
//          return true;
//        } else {
//          var data = json.decode(res.body);
//          var message = data['message'];
//          _errorTextOldPassword = message;
//          notifyListeners();
//          return false;
//        }
      } on SocketException catch (e) {
        isBusy = false;
        logger.e(e);
        BotToast.showText(text: StringResources.couldNotReachServer);
        return false;
      } catch (e) {
        isBusy = false;
        logger.e(e);
        BotToast.showText(text: StringResources.somethingIsWrong);
        return false;
      }
    } else {
      logger.i('invalid');
      return false;
    }
  }
}
