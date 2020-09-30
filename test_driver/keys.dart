import 'package:flutter_driver/flutter_driver.dart';

class Keys{
  //Common Keys
  static final backButton = find.byTooltip('Back');
  static final datePickerKey = find.byValueKey('datePickerKey');
  static final doneButtonKey = find.byValueKey('doneButtonKey');

  //Home


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
  //

  //company edit profile
    //view Screen
  static final companyEditProfileAppBarKey = find.byValueKey('companyEditProfileAppBarKey');
  static final companyViewProfileListViewKey = find.byValueKey('companyViewProfileListViewKey');
  static final companyEditProfileIconKey = find.byValueKey('companyEditProfileIconKey');
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
  static final companyAreaTextfieldKey = find.byValueKey('companyAreaTextfieldKey');
  static final pickLocationTextKey = find.byValueKey('pickLocationTextKey');

  static final editProfileSaveButton = find.byValueKey('editProfileSaveButton');

  //Bottom nav bar keys
  static final bottomNavBarProfileKey = find.byValueKey('bottomNavBarProfileKey');
  static final bottomNavBarDashboardKey = find.byValueKey('bottomNavBarDashboardKey');
  static final bottomNavBarManageJobsKey = find.byValueKey('bottomNavBarManageJobsKey');
  static final bottomNavBarCandidatesKey = find.byValueKey('bottomNavBarCandidatesKey');
  static final PostJobsFloatingActionButtonKey = find.byTooltip('Post');
  //Dashboard
  static final infoboxJobsPostedTextKey = find.byValueKey('infoboxJobsPostedTextKey');
  static final infoboxApplicationsTextKey = find.byValueKey('infoboxApplicationsTextKey');
  static final infoboxShortListedTextKey = find.byValueKey('infoboxShortListedTextKey');


  //Post Job
  static final postJobPostAndUpdateButtonKey = find.byValueKey('postJobPostAndUpdateButtonKey');
  static final postJobDraftButtonKey = find.byValueKey('postJobDraftButtonKey');
  static final singleChildScrollViewKey = find.byValueKey('singleChildScrollViewKey');
  static final postJobAppBarKey = find.byValueKey('postJobAppBarKey');
  static final jobTitleTextfieldKey = find.byValueKey('jobTitleTextfieldKey');
  static final jobDescriptionFieldKey = find.byValueKey('jobDescriptionFieldKey');
  static final categoryKey = find.byValueKey('categoryKey');
  static final genderDropdownSelectKey = find.byValueKey('genderDropdownSelectKey');
  static final experienceDropdownSelectKey = find.byValueKey('experienceDropdownSelectKey');
  static final qualificationDropdownSelectKey = find.byValueKey('qualificationDropdownSelectKey');
  static final vacancyTextfieldKey = find.byValueKey('vacancyTextfieldKey');
  static final salaryAmountRadioButtonKey = find.byValueKey('salaryAmountRadioButtonKey');
  static final salaryRangeRadioButtonKey = find.byValueKey('salaryRangeRadioButtonKey');
  static final salaryNegotiableRadioButtonKey = find.byValueKey('salaryNegotiableRadioButtonKey');
  static final salaryAmountTextfieldKey = find.byValueKey('salaryAmountTextfieldKey');
  static final salaryMinTextfieldKey = find.byValueKey('salaryMinTextfieldKey');
  static final salaryMaxTextfieldKey = find.byValueKey('salaryMaxTextfieldKey');
  static final applicationDeadlineDatePickerKey = find.byValueKey('applicationDeadlineDatePickerKey');
  static final responsibilitiesRichtextKey = find.byValueKey('responsibilitiesRichtextKey');
  static final educationRichtextKey = find.byValueKey('educationRichtextKey');
  static final jobAdditionalRequirementsRichtextKey = find.byValueKey('jobAdditionalRequirementsRichtextKey');
  static final otherBenefitsRichtextKey = find.byValueKey('otherBenefitsRichtextKey');
  static final jobLocationTextfieldKey = find.byValueKey('jobLocationTextfieldKey');
  static final jobAreaTextfieldKey = find.byValueKey('jobAreaTextfieldKey');
  static final jobCityDropDownListKey = find.byValueKey('jobCityDropDownListKey');
  static final jobSiteDropDownListKey = find.byValueKey('jobSiteDropDownListKey');
  static final jobNatureDropDownListKey = find.byValueKey('jobNatureDropDownListKey');
  static final jobTypeDropDownListKey = find.byValueKey('jobTypeDropDownListKey');
  static final jobAboutCompanyTextfieldKey = find.byValueKey('jobAboutCompanyTextfieldKey');

}