import 'package:flutter_driver/flutter_driver.dart';

class Keys{
  //Common Keys
  static final backButton = find.byTooltip('Back');
  static final datePickerKey = find.byValueKey('datePickerKey');
  static final doneButtonKey = find.byValueKey('doneButtonKey');


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
    //view Screen
  static final companyEditProfileAppBarKey = find.byValueKey('companyEditProfileAppBarKey');
    //edit screen
  static final companyEditProfileListViewKey = find.byValueKey('companyEditProfileListViewKey'); //for listView Scroll
  static final companyNameTextfieldKey = find.byValueKey('companyNameTextfieldKey');
  static final companyProfileTextfieldKey = find.byValueKey('companyProfileTextfieldKey');
  static final companyYearsOfEstablishmentDateFieldKey = find.byValueKey('companyYearsOfEstablishmentDateFieldKey');
  static final basisMembershipTextfieldKey = find.byValueKey('basisMembershipTextfieldKey');
  static final companyAddressTextfieldKey = find.byValueKey('companyAddressTextfieldKey');
  static final CompanyCityDropdownListKey = find.byValueKey('CompanyCityDropdownListKey');

  static final contactNoTextfieldNo1Key = find.byValueKey('contactNoTextfieldNo1Key');
  static final contactNoTextfieldNo2Key = find.byValueKey('contactNoTextfieldNo2Key');
  static final contactNoTextfieldNo3Key = find.byValueKey('contactNoTextfieldNo3Key');
  static final companyWebAddressTextfieldKey = find.byValueKey('companyWebAddressTextfieldKey');
  static final nameInBdJobsTextfieldKey = find.byValueKey('nameInBdJobsTextfieldKey');
  static final nameInFacebookTextfieldKey = find.byValueKey('nameInFacebookTextfieldKey');
  static final nameInGoogleTextfieldKey = find.byValueKey('nameInGoogleTextfieldKey');
  static final companyOrganizationHeadNameTextKey = find.byValueKey('companyOrganizationHeadNameTextKey');
  static final companyOrganizationHeadDesignationTextKey = find.byValueKey('companyOrganizationHeadDesignationTextKey');
  static final companyOrganizationHeadMobileNoTextKey = find.byValueKey('companyOrganizationHeadMobileNoTextKey');
  static final legalStructureTextKey = find.byValueKey('legalStructureTextKey');
  static final companyNoOFHumanResourcesTextKey = find.byValueKey('companyNoOFHumanResourcesTextKey');
  static final companyNoOFItResourcesTextKey = find.byValueKey('companyNoOFItResourcesTextKey');
  static final companyContactPersonNameTextKey = find.byValueKey('companyContactPersonNameTextKey');
  static final companyContactPersonDesignationTextKey = find.byValueKey('companyContactPersonDesignationTextKey');
  static final companyContactPersonMobileNoTextKey = find.byValueKey('companyContactPersonMobileNoTextKey');
  static final companyContactPersonEmailTextKey = find.byValueKey('companyContactPersonEmailTextKey');
  static final pickLocationTextKey = find.byValueKey('pickLocationTextKey');

  static final editProfileSaveButton = find.byValueKey('editProfileSaveButton');
}