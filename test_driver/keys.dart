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

  //company edit profile
  static final companyEditProfileAppBarKey = find.byValueKey('companyEditProfileAppBarKey');
  static final companyNameTextfieldKey = find.byValueKey('companyNameTextfieldKey');
  static final companyProfileTextfieldKey = find.byValueKey('companyProfileTextfieldKey');
  static final companyYearsOfEstablishmentDateFieldKey = find.byValueKey('companyYearsOfEstablishmentDateFieldKey');
  static final basisMembershipTextfieldKey = find.byValueKey('basisMembershipTextfieldKey');
  static final companyAddressTextfieldKey = find.byValueKey('companyAddressTextfieldKey');

  static final editProfileSaveButton = find.byValueKey('editProfileSaveButton');
}