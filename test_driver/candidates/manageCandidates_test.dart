import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


main(){
  manageCandidates();
}
Future<void> manageCandidates()async{

  group('Manage Candidates Test', () {

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
    test('Try to login with registered email and password', () async {
      await driver.tap(Keys.emailAddressTextfieldKey);
      await driver.enterText('rahat@ishraak.com');
      await driver.tap(Keys.passwordTextfieldKey);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButtonKey);
      await Future.delayed(const Duration(seconds: 4), () {});
      await expect(await driver.getText(Keys.appBarTitleKey), 'Dashboard');
    });

    test('Go to Manage Candidates screen', () async {
      await driver.tap(Keys.bottomNavBarCandidatesKey);
      await Future.delayed(const Duration(seconds: 3), () {});
      await expect(await driver.getText(Keys.appBarTitleKey), 'Manage Candidates');
    });

    test('Candidate Profile is showing', () async {
      await driver.tap(Keys.candidateProfileTileKey1);
      await Future.delayed(const Duration(seconds: 3), () {});
      await expect(await driver.getText(Keys.candidateProfileAppBarKey), 'Rahat Mahmud');
    });

    test('Candidate Profile 2 is showing', () async {
      await driver.tap(Keys.candidateProfileTileKey2);
      await Future.delayed(const Duration(seconds: 3), () {});
      await expect(await driver.getText(Keys.candidateProfileAppBarKey), 'MD. Shofiullah');
    });

    test('Check Candidate Shortlisted button ', () async {
      await driver.tap(Keys.candidatesShortlistedIconButtonKey);
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(Keys.candidatesShortlistedIconButtonKey);
    });

    test('Check Candidate to Message using the message icon ', () async {
      await driver.tap(Keys.candidatesMessageIconButtonKey1);
      await driver.tap(Keys.candidatesMessageTapOnWriteTextfield);
      await driver.enterText('Hello! You have been shortlisted for interview');
      await driver.tap(Keys.messageSendButtonKey);
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(Keys.backButton);
    });

    test('Check Candidate to Message using the message icon ', () async {
      await driver.tap(Keys.candidatesMessageIconButtonKey2);
      await driver.tap(Keys.candidatesMessageTapOnWriteTextfield);
      await driver.enterText('Hello! You have been shortlisted for interview');
      await driver.tap(Keys.messageSendButtonKey);
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(Keys.backButton);
    });

  });

}
