import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


main(){
  editProfileTest();
}
Future<void> editProfileTest()async{

  group('Company Edit Profile Test', () {

    //call key codes will be here if needed

    FlutterDriver driver;
    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    //test cases are started from here
    test('get into edit screen', () async {
      await driver.tap(Keys.bottomNavBarProfileKey);
    });
    test('Insert company name', () async {
      await expect(await driver.getText(Keys.companyEditProfileAppBarKey), 'Update Info');
      await driver.tap(Keys.companyEditProfileIconKey);
      await driver.tap(Keys.companyNameTextfieldKey);
      await driver.enterText('Company Name');
      await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 4),() {});
      await expect(await driver.getText(find.text('Company Name')), 'Company Name');

    });

    test('Insert Company Profile', () async {
      await driver.tap(Keys.companyEditProfileIconKey);
      await driver.tap(Keys.companyProfileTextfieldKey);
      await driver.enterText('Company Profile');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 4),() {});
      await expect(await driver.getText(find.text('Company Profile')), 'Company Profile');
    });

    test('Years of Establishment date picker', () async {
      await driver.tap(Keys.companyEditProfileIconKey);
      await driver.tap(Keys.companyYearsOfEstablishmentDateFieldKey);
      await driver.scrollUntilVisible(Keys.datePickerKey, find.text('2000'), dyScroll: -10);
      await driver.tap(Keys.doneButtonKey);
      await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 4),() {});
      await expect(await driver.getText(find.text('2000')), '2000');

    });

    test('Check Legal Stricture ', () async {
      await driver.tap(Keys.companyEditProfileIconKey);
      await driver.tap(Keys.legalStructureTextKey);
      await driver.enterText('011110');
      await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
      await expect(await driver.getText(find.text('011110')), '011110');
    });

    test('Check No of Human resources ', () async {
      await driver.tap(Keys.companyEditProfileIconKey);
      await driver.tap(Keys.companyNoOFHumanResourcesTextKey);
      await driver.enterText('050');
      await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
      await expect(await driver.getText(find.text('050')), '050');
    });

    test('Check No of IT resources', () async {
      await driver.tap(Keys.companyEditProfileIconKey);
      await driver.scrollUntilVisible(Keys.companyEditProfileListViewKey, Keys.companyNoOFItResourcesTextKey, dyScroll: -20);
      await driver.tap(Keys.companyNoOFItResourcesTextKey);
      await driver.enterText('010');
      await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
      await expect(await driver.getText(find.text('010')), '010');
    });

    test('Insert Company address', () async {
      await driver.tap(Keys.companyEditProfileIconKey);
      await driver.scrollUntilVisible(Keys.companyEditProfileListViewKey, Keys.companyAddressTextfieldKey, dyScroll: -50);
      await driver.tap(Keys.companyAddressTextfieldKey);
      await driver.enterText('3/3, Dhaka, Bangladesh');
      await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 4),() {});
      await expect(await driver.getText(find.text('3/3, Dhaka, Bangladesh')), '3/3, Dhaka, Bangladesh');
    });

    test('Check company area', () async {
      await driver.tap(Keys.companyEditProfileIconKey);
      await driver.scrollUntilVisible(Keys.companyEditProfileListViewKey, Keys.companyAreaTextfieldKey, dyScroll: -100);
      await driver.tap(Keys.companyAreaTextfieldKey);
      await driver.enterText('Bashundhara R/A');
      await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 4),() {});
      await expect(await driver.getText(find.text('Bashundhara R/A')), 'Bashundhara R/A');
    });

    test('Select Company City from dropdown list', () async {
      await driver.tap(Keys.companyEditProfileIconKey);
      await driver.scrollUntilVisible(Keys.companyEditProfileListViewKey, Keys.CompanyCityDropdownListKey, dyScroll: -200);
      await driver.tap(Keys.CompanyCityDropdownListKey);
      await driver.tap(find.text('Dhaka, Bangladesh'));
      await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 2),() {});
      await expect(await driver.getText(find.text('Dhaka, Bangladesh')), 'Dhaka, Bangladesh');
    });

    test('Insert company contact number One', () async {
      await driver.tap(Keys.companyEditProfileIconKey);
      await driver.scrollUntilVisible(Keys.companyEditProfileListViewKey, Keys.contactNoTextfieldNo1Key, dyScroll: -200);
      await driver.tap(Keys.contactNoTextfieldNo1Key);
      await driver.enterText('01917508681');
      await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
      await expect(await driver.getText(find.text('01917508681')), '01917508681');
    });

    test('Insert company contact number Two', () async {
      await driver.tap(Keys.companyEditProfileIconKey);
      await driver.scrollUntilVisible(Keys.companyEditProfileListViewKey, Keys.contactNoTextfieldNo2Key, dyScroll: -200);
      await driver.tap(Keys.contactNoTextfieldNo2Key);
      await driver.enterText('01917508682');
      await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
      await expect(await driver.getText(find.text('01917508682')), '01917508682');
    });

    test('Insert company contact number 3', () async {
      await driver.tap(Keys.companyEditProfileIconKey);
      await driver.scrollUntilVisible(Keys.companyEditProfileListViewKey, Keys.contactNoTextfieldNo3Key, dyScroll: -200);
      await driver.tap(Keys.contactNoTextfieldNo3Key);
      await driver.enterText('01917508683');
      await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
      await expect(await driver.getText(find.text('01917508683')), '01917508683');
    });

    test('Insert Company web address', () async {
      await driver.tap(Keys.companyEditProfileIconKey);
      await driver.scrollUntilVisible(Keys.companyEditProfileListViewKey, Keys.companyWebAddressTextfieldKey, dyScroll: -300);
      await driver.tap(Keys.companyWebAddressTextfieldKey);
      await driver.enterText('www.companyweb.com');
      await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
      await expect(await driver.getText(find.text('www.companyweb.com')), 'www.companyweb.com');
    });

    test('Check Organization head ', () async {
      await driver.tap(Keys.companyEditProfileIconKey);
      await driver.scrollUntilVisible(Keys.companyEditProfileListViewKey, Keys.companyOrganizationHeadNameTextKey, dyScroll: -300);
      await driver.tap(Keys.companyOrganizationHeadNameTextKey);
      await driver.enterText('Organization head name');
      await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
      await expect(await driver.getText(find.text('Organization head name')), 'Organization head name');
    });

    test('Check Organization head designation ', () async {
      await driver.tap(Keys.companyOrganizationHeadDesignationTextKey);
      await driver.enterText('Organization Head Designation');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
    });
    test('Check Organization head Mobile ', () async {
      await driver.tap(Keys.companyOrganizationHeadMobileNoTextKey);
      await driver.enterText('0101');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
    });

    test('Check Contact person name', () async {
      await driver.scrollUntilVisible(Keys.companyEditProfileListViewKey, Keys.companyContactPersonNameTextKey, dyScroll: -40);
      await driver.tap(Keys.companyContactPersonNameTextKey);
      await driver.enterText('Contact Person Name');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
    });

    test('Check Contact person Designation', () async {
      await driver.scrollUntilVisible(Keys.companyEditProfileListViewKey, Keys.companyContactPersonDesignationTextKey, dyScroll: -40);
      await driver.tap(Keys.companyContactPersonDesignationTextKey);
      await driver.enterText('Contact Person Designation');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
    });

    test('Check Contact person Mobile No', () async {
      await driver.scrollUntilVisible(Keys.companyEditProfileListViewKey, Keys.companyContactPersonMobileNoTextKey, dyScroll: -40);
      await driver.tap(Keys.companyContactPersonMobileNoTextKey);
      await driver.enterText('00000');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
    });

    test('Check Contact person Email', () async {
      await driver.scrollUntilVisible(Keys.companyEditProfileListViewKey, Keys.companyContactPersonEmailTextKey, dyScroll: -40);
      await driver.tap(Keys.companyContactPersonEmailTextKey);
      await driver.enterText('email@email.com');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
    });

    test('Basis Membership Number', () async {
      await driver.tap(Keys.basisMembershipTextfieldKey);
      await driver.enterText('1234');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    test('Check name in Google', () async {
      await driver.tap(Keys.nameInGoogleTextfieldKey);
      await driver.enterText('Company Google Name');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
    });

    test('Insert name in bdjobs', () async {
      await driver.tap(Keys.nameInBdJobsTextfieldKey);
      await driver.enterText('Company BDjobs Name');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
    });

    test('Insert name in FaceBook', () async {
      await driver.tap(Keys.nameInFacebookTextfieldKey);
      await driver.enterText('Company FaceBook Name');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 3),() {});
    });



  });

}
