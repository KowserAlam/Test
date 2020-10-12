import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'auth/login_test.dart';
import 'candidates/manageCandidates_test.dart';
import 'dashboard/dashboard_test.dart';
import 'keys.dart';
import 'manage_jobs/manageJobs_test.dart';
import 'post_job/postJob_test.dart';
import 'profile/profile_test.dart';


main() {
  companyAllTest();
}

Future<void> companyAllTest() async {
  group('All TestCase at Once: ', () {

    //final jobListSearchToggleButtonKey

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

    loginTest();

    test('Login to company account', () async {
      await expect(await driver.getText(Keys.welcomeBackKey), 'Welcome back!');
      await driver.tap(Keys.emailAddressTextfieldKey);
      await driver.enterText('rahat@ishraak.com');
      await driver.tap(Keys.passwordTextfieldKey);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButtonKey);
      await expect(await driver.getText(Keys.appBarTitleKey), 'Dashboard');
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    dashboardTest();

    editProfileTest();

    manageJobsTest();

    manageCandidates();

    postJobTest();

  });
}
