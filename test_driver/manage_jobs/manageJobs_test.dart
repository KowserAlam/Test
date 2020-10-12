import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


main(){
  manageJobsTest();
}
Future<void> manageJobsTest()async{

  group('Manage Jobs Test', () {

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
    /*test('Try to login with registered email and password', () async {
      await driver.tap(Keys.emailAddressTextfieldKey);
      await driver.enterText('rahat@ishraak.com');
      await driver.tap(Keys.passwordTextfieldKey);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButtonKey);
      await Future.delayed(const Duration(seconds: 4), () {});
      await expect(await driver.getText(Keys.appBarTitleKey), 'Dashboard');
    });*/

    test('Go to manage jobs screen', () async {
      await driver.tap(Keys.bottomNavBarManageJobsKey);
      await expect(await driver.getText(Keys.appBarTitleKey), 'Manage Jobs');
      await Future.delayed(const Duration(seconds: 3), () {});
    });

    test('Check Job details is showing correctly', () async {
      await driver.tap(Keys.menuButtonKey1);
      await driver.tap(Keys.menuPreviewJobDetailsKey);
      await expect(await driver.getText(Keys.jobDetailsAppBarTitleKey), 'Job Details');
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(Keys.backButton);
    });

    test('Check Job details is showing correctly', () async {
      await driver.tap(Keys.menuButtonKey2);
      await driver.tap(Keys.menuPreviewJobDetailsKey);
      await expect(await driver.getText(Keys.jobDetailsAppBarTitleKey), 'Job Details');
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(Keys.backButton);
    });

    test('Check Pagination is working', () async {
      await driver.scrollUntilVisible(Keys.manageJobsListViewKey, Keys.menuButtonKey17, dyScroll: -150);
      await driver.tap(Keys.menuPreviewJobDetailsKey);
      await expect(await driver.getText(Keys.jobDetailsAppBarTitleKey), 'Job Details');
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(Keys.backButton);
      await driver.scrollUntilVisible(Keys.manageJobsListViewKey, Keys.menuButtonKey1, dyScroll: 150);
    });

    test('Check View applications is working', () async {
      await driver.tap(Keys.menuButtonKey1);
      await driver.tap(Keys.menuViewApplicationsTextKey);
      await expect(await driver.getText(Keys.manageCandidatesAppBarTextKey), 'Manage Candidates');
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(Keys.bottomNavBarManageJobsKey);
    });

    test('Check On tile Applications button working which is to see that job applied candidates', () async {
      await driver.tap(Keys.manageCandidatesTileViewApplicationsKey1);
      await expect(await driver.getText(Keys.manageCandidatesAppBarTextKey), 'Manage Candidates');
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(Keys.bottomNavBarManageJobsKey);
    });

    test('Check edit job is working', () async {
      await driver.tap(Keys.menuButtonKey1);
      await driver.tap(Keys.editJobKey);
      await expect(await driver.getText(Keys.postJobAppBarKey), 'UPDATE JOB');
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(Keys.postJobPostAndUpdateButtonKey);
      await expect(await driver.getText(Keys.appBarTitleKey), 'Manage Jobs');
    });

    test('Check copy as new working', () async {
      await driver.tap(Keys.menuButtonKey1);
      await driver.tap(Keys.copyAsNewJobKey);
      await expect(await driver.getText(Keys.postJobAppBarKey), 'POST JOB');
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(Keys.jobTitleTextfieldKey);
      await driver.enterText('Testing Automation Job Title');
      await driver.tap(Keys.postJobDraftButtonKey);
      await driver.scrollUntilVisible(Keys.manageJobsScreenListViewKey, find.text('Testing Automation Job Title') , dyScroll: -200);
    });

    test('Check message icon button is working', () async {
      await driver.tap(Keys.messageIconButtonOnAppbar);
      await expect(await driver.getText(Keys.messageListScreenAppBarKey), 'Messages');
      await Future.delayed(const Duration(seconds: 4), () {});
      await driver.tap(Keys.backButton);
      await expect(await driver.getText(Keys.appBarTitleKey), 'Manage Jobs');
    });

  });

}
