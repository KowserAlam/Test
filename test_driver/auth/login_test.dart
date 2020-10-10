import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


main(){
  loginTest();
}
Future<void> loginTest()async{

  group('Login Test', () {

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
    test('Make sure that we are in the login page and press the signin button where all fields are empty', () async {
      await expect(await driver.getText(Keys.welcomeBackKey), 'Welcome back!');
      await expect(await driver.getText(Keys.loginToYourExistingAccountKey), 'Login to your existing account');
      await driver.tap(Keys.signInButtonKey);
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    test('Try to login without email', () async {
      await driver.tap(Keys.passwordTextfieldKey);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButtonKey);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
    test('Try to login without password', () async {
      await driver.tap(Keys.emailAddressTextfieldKey);
      await driver.enterText('example@ishraak.com');
      await driver.tap(Keys.passwordTextfieldKey);
      await driver.enterText('');
      await driver.tap(Keys.signInButtonKey);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
    test('Try to login with, which is actually not an email', () async {
      await driver.tap(Keys.emailAddressTextfieldKey);
      await driver.enterText('emailField');
      await driver.tap(Keys.passwordTextfieldKey);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButtonKey);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
    test('Try to login with wrong format of password, all numaric ', () async {
      await driver.tap(Keys.emailAddressTextfieldKey);
      await driver.enterText('example@ishraak.com');
      await driver.tap(Keys.passwordTextfieldKey);
      await driver.enterText('0123456789');
      await driver.tap(Keys.signInButtonKey);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
    test('Try to login with wrong format of password, all alphabet ', () async {
      await driver.tap(Keys.emailAddressTextfieldKey);
      await driver.enterText('example@ishraak.com');
      await driver.tap(Keys.passwordTextfieldKey);
      await driver.enterText('abcdefghijkl');
      await driver.tap(Keys.signInButtonKey);
      await Future.delayed(const Duration(seconds: 3), () {});
    });

    test('Try to login with unregistered email and password', () async {
      await driver.tap(Keys.emailAddressTextfieldKey);
      await driver.enterText('unregistered@ishraak.com');
      await driver.tap(Keys.passwordTextfieldKey);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButtonKey);
      await Future.delayed(const Duration(seconds: 3), () {});
    });

    test('Check Forgot Password link is working', () async {
      await driver.tap(Keys.forgotPasswordTextKey);
      await Future.delayed(const Duration(seconds: 3), () {});
      await expect(await driver.getText(Keys.passwordResetScreenAppBarTitleKey), 'Reset Password');
      await driver.tap(Keys.backButton);
    });



  });

}
