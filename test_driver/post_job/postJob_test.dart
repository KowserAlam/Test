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
    test('Check Experience', () async {
      await driver.tap(Keys.experienceDropdownSelectKey);
      await driver.tap(find.text('10'));
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    test('Check Qualification', () async {
      await driver.tap(Keys.qualificationDropdownSelectKey);
      await driver.tap(find.text('BSc in CSE'));
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    test('Check Vacancy', () async {
      await driver.tap(Keys.vacancyTextfieldKey);
      await driver.tap(find.text('3'));
      await Future.delayed(const Duration(seconds: 4),() {});
    });
    test('Check Salary Amount', () async {
      await driver.tap(Keys.salaryAmountRadioButtonKey);
      await driver.tap(Keys.salaryAmountTextfieldKey);
      await driver.enterText('20000');
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    test('Check Salary Range', () async {
      await driver.tap(Keys.salaryRangeRadioButtonKey);
      await driver.tap(Keys.salaryMinTextfieldKey);
      await driver.enterText('5000');
      await driver.tap(Keys.salaryMaxTextfieldKey);
      await driver.enterText('10000');
      await Future.delayed(const Duration(seconds: 4),() {});
    });
    test('Check Nagotiable and get back to salary amount', () async {
      await driver.tap(Keys.salaryNegotiableRadioButtonKey);
      await driver.tap(Keys.salaryRangeRadioButtonKey);
      await driver.tap(Keys.salaryMinTextfieldKey);
      await driver.enterText('');
      await driver.tap(Keys.salaryMaxTextfieldKey);
      await driver.enterText('');
      await driver.tap(Keys.salaryAmountRadioButtonKey);
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    test('Check Deadline and pick a date', () async {
      await driver.tap(Keys.applicationDeadlineDatePickerKey);
      await driver.scrollUntilVisible(Keys.datePickerKey, find.text('2021'), dyScroll: -10);
      await driver.tap(Keys.doneButtonKey);
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    test('Check Responsibilities', () async {
      await driver.scrollUntilVisible(Keys.singleChildScrollViewKey, Keys.responsibilitiesRichtextKey, dyScroll: -30);
      await driver.tap(Keys.responsibilitiesRichtextKey);
      await driver.enterText('Sample Responsibilities');
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    test('Check Education', () async {
      await driver.scrollUntilVisible(Keys.singleChildScrollViewKey, Keys.educationRichtextKey, dyScroll: -30);
      await driver.tap(Keys.educationRichtextKey);
      await driver.enterText('Sample Education');
      await Future.delayed(const Duration(seconds: 4),() {});
    });

    test('Check Education', () async {
      await driver.scrollUntilVisible(Keys.singleChildScrollViewKey, Keys.jobAdditionalRequirementsRichtextKey, dyScroll: -30);
      await driver.tap(Keys.jobAdditionalRequirementsRichtextKey);
      await driver.enterText('Sample Additional Requirement');
      await Future.delayed(const Duration(seconds: 4),() {});
    });

  });

}
