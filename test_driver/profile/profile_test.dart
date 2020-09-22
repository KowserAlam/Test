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
    test('Insert company name', () async {
      await expect(await driver.getText(Keys.companyEditProfileAppBarKey), 'Update Info');
      await driver.tap(Keys.companyNameTextfieldKey);
      await driver.enterText('Company Name');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 4),() {});

    });

    test('Insert Company Profile', () async {
      await driver.tap(Keys.companyProfileTextfieldKey);
      await driver.enterText('Company Profile');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    test('Years of Establishment date picker', () async {
      await driver.tap(Keys.companyYearsOfEstablishmentDateFieldKey);
      await driver.scrollUntilVisible(Keys.datePickerKey, find.text('2000'), dyScroll: -10);
      await driver.tap(Keys.doneButtonKey);
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 4),() {});

    });

    test('Basis Membership Number', () async {
      await driver.tap(Keys.basisMembershipTextfieldKey);
      await driver.enterText('1234');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    test('Insert Company address', () async {
      await driver.tap(Keys.companyAddressTextfieldKey);
      await driver.enterText('3/3, Dhaka, Bangladesh');
      //await driver.tap(Keys.editProfileSaveButton);
      await Future.delayed(const Duration(seconds: 4),() {});
    });


  });

}
