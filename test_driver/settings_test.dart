import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'keys.dart';


main(){
  settings();
}
Future<void> settings()async{
  group('Settings Test: ', () {


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
    test('Getting to Change Password screen', () async {
      await Future.delayed(const Duration(seconds: 3), (){});
      await driver.tap(Keys.bottomNavBarDashboardKey);
      await driver.tap(Keys.leftMenubarIconKey);
      await driver.tap(Keys.leftMenubarsettingsIconKey);
      await expect(await driver.getText(Keys.settingsAppBarTextKey), 'Settings');
      await driver.tap(Keys.goIntoChangePassword);
      await expect(await driver.getText(Keys.changePasswordAppbarTitle), 'Change Password');
      await Future.delayed(const Duration(seconds: 5), (){});
    });


    test('Check with wrong old password', () async {
      await driver.tap(Keys.currentPasswordTextboxKey);
      await driver.enterText('2828282r');
      await driver.tap(Keys.newPasswordTextboxKey);
      await driver.enterText('1234567d');
      await driver.tap(Keys.passwordChangeSubmitButtonKey);
      await expect(await driver.getText(Keys.changePasswordAppbarTitle), 'Change Password');
      await Future.delayed(const Duration(seconds: 5), (){});
    });

    test('Check with wrong password format', () async {
      await driver.tap(Keys.currentPasswordTextboxKey);
      await driver.enterText('11111111111');
      await driver.tap(Keys.newPasswordTextboxKey);
      await driver.enterText('11111111111');
      await driver.tap(Keys.passwordChangeSubmitButtonKey);
      await expect(await driver.getText(Keys.changePasswordAppbarTitle), 'Change Password');
      await Future.delayed(const Duration(seconds: 5), (){});
    });


    test('Give proper information to update password', () async {
      await driver.tap(Keys.currentPasswordTextboxKey);
      await driver.enterText('1234567r');
      await driver.tap(Keys.newPasswordTextboxKey);
      await driver.enterText('1234567r');
      await driver.tap(Keys.passwordChangeSubmitButtonKey);
      await Future.delayed(const Duration(seconds: 2), (){});
      await expect(await driver.getText(Keys.settingsAppBarTextKey), 'Settings');
      await driver.tap(Keys.leftMenubarIconKey);
      //missing signInWelcomeText testcase here
    });

    test('Check if password have been updated by logging in with updated password', () async {
      await driver.tap(Keys.emailAddressTextfieldKey);
      await driver.enterText('rahat@ishraak.com');
      await driver.tap(Keys.passwordTextfieldKey);
      await driver.enterText('1234567s');
      await driver.tap(Keys.signInButtonKey);
      //await expect(await driver.getText(Keys.dashboardAppbardTitle), 'Dashboard');
    });





  });

}
