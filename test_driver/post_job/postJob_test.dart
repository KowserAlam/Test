import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


main(){
  postJobTest();
}
Future<void> postJobTest()async{

  group('Post Job Test', () {

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
    test('Navigate to Post Job screen from bottom navigation bar', () async {
      await driver.tap(Keys.PostJobsFloatingActionButtonKey);
      await Future.delayed(const Duration(seconds: 4),() {});
      await expect(await driver.getText(Keys.postJobAppBarKey), 'POST JOB');
    });

    test('Check job title textfield', () async {
      await driver.tap(Keys.jobTitleTextfieldKey);
      await driver.enterText('Sample Job Title');
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    test('Check job description', () async {
      await driver.tap(Keys.jobDescriptionFieldKey);
      await driver.enterText('Sample Job Description, Sample Job Description');
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    test('Check Category', () async {
      await driver.tap(Keys.categoryKey);
      await driver.tap(find.text('Back-End Developer'));
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    test('Check Gender', () async {
      await driver.tap(Keys.genderDropdownSelectKey);
      await driver.tap(find.text('Any'));
      await Future.delayed(const Duration(seconds: 4),() {});
    });

  });

}
