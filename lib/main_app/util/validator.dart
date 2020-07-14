import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/method_extension.dart';

class Validator {
  String nullFieldValidate(String value) =>
      value.isEmptyOrNull ? StringResources.thisFieldIsRequired : null;





  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (value.isEmpty) {
      return StringResources.pleaseEnterEmailText;
    }else if (!regex.hasMatch(value))
      return StringResources.pleaseEnterAValidEmailText;
    else
      return null;
  }

  String validatePassword(String value) {
    final RegExp _passwordRegExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
    );
    if (value.isEmpty) {
      return StringResources.thisFieldIsRequired;
    } else if (!_passwordRegExp.hasMatch(value)) {
      return StringResources.passwordMustBeEight;
    } else {
      return null;
    }
  }

  String validateEmptyPassword(String value) {
    if (value.isEmpty) {
      return StringResources.pleaseEnterPasswordText;
    }  else {
      return null;
    }
  }

  String validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return StringResources.passwordDoesNotMatch;
    } else {
      return null;
    }
  }

  String validatePhoneNumber(String value) {
//    Pattern pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    Pattern pattern = r'\+?(88)?0?1[56789][0-9]{8}\b';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return StringResources.enterValidPhoneNumber;
    else
      return null;
  }

  String validateNullablePhoneNumber(String value) {
    Pattern pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    if(value.isEmpty){
      return null;
    }
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return StringResources.enterValidPhoneNumber;
    else
      return null;
  }

  String verificationCodeValidator(String value) {
    Pattern pattern = r'^(\d{6})?$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return StringResources.invalidCode;
    else
      return null;
  }

   String decimalNumberFieldValidateOptional(String value){
    Pattern pattern = r'^[1-9]\d*(\.\d+)?$';
    RegExp regex = new RegExp(pattern);
    if(value.isEmpty){
      return null;
    }

    if (!regex.hasMatch(value))
      return StringResources.pleaseEnterDecimalValue;
    else
      return null;
  }
   String integerNumberNullableValidator(String value){
    Pattern pattern = r'^[1-9][0-9]*$';
    RegExp regex = new RegExp(pattern);
    if(value.isEmpty){
      return null;
    }

    if (!regex.hasMatch(value))
      return StringResources.pleaseEnterValidNumber;
    else
      return null;
  }
   String integerNumberValidator(String value){
    Pattern pattern = r'^[1-9][0-9]*$';
    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(value))
      return StringResources.pleaseEnterValidNumber;
    else
      return null;
  }
   String moneyAmountNullableValidate(String value){
    Pattern pattern = r'^(?=.*?\d)^\$?(([1-9]\d{0,2}(,\d{3})*)|\d+)?(\.\d{1,2})?$';
    RegExp regex = new RegExp(pattern);
    if(value.isEmpty){
      return null;
    }
    if (!regex.hasMatch(value))
      return StringResources.pleaseEnterValidAmount;
    else
      return null;
  }


  String nameValidator(String value){
    Pattern pattern = '/[a-zA-Z]/i';
    RegExp regExp = new RegExp(pattern);
    if(value.length > 0){
      if(!regExp.hasMatch(value)){
        return StringResources.invalidName;
      }else{
        return null;
      }
    }else{
      return StringResources.thisFieldIsRequired;
    }
  }

  String expertiseFieldValidate(String value){
    double x;
    Pattern pattern = r'^([0-9]{1,2})+(\.[0-9]{1,2})?$';
    RegExp regex = new RegExp(pattern);
    if(value.isEmpty){
      return StringResources.thisFieldIsRequired;
    }else {
      if(!regex.hasMatch(value)){
        return StringResources.twoDecimal;
      }else{
        x = double.parse(value);
        if(x >=0 && x <11){
          return null;
        }else{
          return StringResources.valueWithinRange;
        }
      }
    }
  }

}
