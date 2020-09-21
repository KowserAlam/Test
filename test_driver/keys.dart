import 'package:flutter_driver/flutter_driver.dart';

class Keys{
  //Common Keys
  static final backButton = find.byTooltip('Back');


  //login screen
  static final welcomeBackKey = find.byValueKey('welcomeBackKey');
  static final loginToYourExistingAccountKey = find.byValueKey('loginToYourExistingAccountKey');
  static final emailAddressTextfieldKey = find.byValueKey('emailAddressTextfieldKey');
  static final passwordTextfieldKey = find.byValueKey('passwordTextfieldKey');
  static final signInButtonKey = find.byValueKey('signInButtonKey');
  static final paswwordVisibilityOn = find.byValueKey('paswwordVisibilityOn');
  static final paswwordVisibilityOff = find.byValueKey('paswwordVisibilityOff');
  static final forgotPasswordTextKey = find.byValueKey('forgotPasswordTextKey');
  static final passwordResetScreenAppBarTitleKey = find.byValueKey('passwordResetScreenAppBarTitleKey');
}