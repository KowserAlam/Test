import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


main(){
  forgotPasswordTest();
}
Future<void> forgotPasswordTest()async{
  group('Forgot Password test', () {
    final passwordResetTextField = find.byValueKey('passwordResetTextField');
    final passwordResetButton = find.byValueKey('passwordResetButton');
    final forgotPasswordLink = find.text('Forgot Password ?');
    final backButton = find.byTooltip('Back');
    //final forgotResetErrorText = find.text('There is no active user associated with this e-mail address or the password can not be changed');

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
    test('Click on forgot password link from login page', () async {
      await driver.tap(forgotPasswordLink);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
    test('Try to change password with wrong email format', () async {
      await driver.tap(passwordResetTextField);
      await driver.enterText('wrongEmailFormat');
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(passwordResetButton);
    });
    test('Try to change password with Unregistered email', () async {
      await driver.tap(passwordResetTextField);
      await driver.enterText('unregistered@ishraak.com');
      await driver.tap(passwordResetButton);
      await Future.delayed(const Duration(seconds: 3), () {});
    });
    test('Try to change password with Registered email', () async {
      await driver.tap(passwordResetTextField);
      await driver.enterText('mahmudoni01@gmail.com');
      await driver.tap(passwordResetButton);
      await Future.delayed(const Duration(seconds: 3), () {});
      await driver.tap(backButton);
    });
  });

}
