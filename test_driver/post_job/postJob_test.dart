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
    test('Try to login with registered email and password', () async {
      await driver.tap(Keys.emailAddressTextfieldKey);
      await driver.enterText('rahat@ishraak.com');
      await driver.tap(Keys.passwordTextfieldKey);
      await driver.enterText('1234567r');
      await driver.tap(Keys.signInButtonKey);
      await Future.delayed(const Duration(seconds: 5), () {});
    });

    test('Navigate to Post Job screen from bottom navigation bar', () async {
      await driver.tap(Keys.PostJobsFloatingActionButtonKey);
      await Future.delayed(const Duration(seconds: 4),() {});
      await expect(await driver.getText(Keys.postJobAppBarKey), 'POST JOB');
    });

    test('Check job title textfield', () async {
      await driver.tap(Keys.jobTitleTextfieldKey);
      await driver.enterText('Sample Job Title');
      await Future.delayed(const Duration(seconds: 2),() {});
    });

    test('Check job description', () async {
      await driver.tap(Keys.jobDescriptionFieldKey);
      await driver.enterText('Sample Job Description, Sample Job Description');
      await Future.delayed(const Duration(seconds: 2),() {});
    });

    test('Check Category', () async {
      await driver.tap(Keys.categoryKey);
      await driver.tap(find.text('Advisor'));
      await Future.delayed(const Duration(seconds: 2),() {});
    });

    test('Check Gender', () async {
      await driver.tap(Keys.genderDropdownSelectKey);
      await driver.tap(find.text('Any'));
      await Future.delayed(const Duration(seconds: 2),() {});
    });
    test('Check Experience', () async {
      await driver.tap(Keys.experienceDropdownSelectKey);
      await driver.tap(find.text('10'));
      await Future.delayed(const Duration(seconds: 2),() {});
    });

    test('Check Qualification', () async {
      await driver.tap(Keys.qualificationDropdownSelectKey);
      await driver.tap(find.text('A Level'));
      await Future.delayed(const Duration(seconds: 2),() {});
    });

    test('Check Vacancy', () async {
      await driver.tap(Keys.vacancyTextfieldKey);
      await driver.enterText('3');
      await Future.delayed(const Duration(seconds: 2),() {});
    });
    test('Check Salary Amount', () async {
      await driver.tap(Keys.salaryAmountRadioButtonKey);
      await driver.tap(Keys.salaryAmountTextfieldKey);
      await driver.enterText('20000');
      await Future.delayed(const Duration(seconds: 3),() {});
    });

    test('Check Salary Range', () async {
      await driver.tap(Keys.salaryRangeRadioButtonKey);
      await driver.tap(Keys.salaryMinTextfieldKey);
      await driver.enterText('5000');
      await driver.tap(Keys.salaryMaxTextfieldKey);
      await driver.enterText('10000');
      await Future.delayed(const Duration(seconds: 3),() {});
    });
    test('Check Nagotiable and get back to salary amount', () async {
      await driver.tap(Keys.salaryNegotiableRadioButtonKey);
      await driver.tap(Keys.salaryRangeRadioButtonKey);
      await driver.tap(Keys.salaryMinTextfieldKey);
      await driver.enterText('');
      await driver.tap(Keys.salaryMaxTextfieldKey);
      await driver.enterText('');
      await driver.tap(Keys.salaryAmountRadioButtonKey);
      await Future.delayed(const Duration(seconds: 3),() {});
    });

    test('Check Deadline and pick a date', () async {
      await driver.tap(Keys.applicationDeadlineDatePickerKey);
      await driver.scrollUntilVisible(Keys.datePickerKey, find.text('2021'), dyScroll: -10);
      await driver.tap(Keys.doneButtonKey);
      await Future.delayed(const Duration(seconds: 3),() {});
    });

    test('Check Responsibilities', () async {
      await driver.scrollUntilVisible(Keys.singleChildScrollViewKey, Keys.responsibilitiesRichtextKey, dyScroll: -40);
      await driver.tap(Keys.responsibilitiesRichtextKey);
      await driver.enterText('Sample Responsibilities');
      await Future.delayed(const Duration(seconds: 2),() {});
    });

    test('Check Education', () async {
      await driver.scrollUntilVisible(Keys.singleChildScrollViewKey, Keys.educationRichtextKey, dyScroll: -40);
      await driver.tap(Keys.educationRichtextKey);
      await driver.enterText('Sample Education');
      await Future.delayed(const Duration(seconds: 2),() {});
    });

    test('Check Additional Requirement', () async {
      await driver.scrollUntilVisible(Keys.singleChildScrollViewKey, Keys.jobAdditionalRequirementsRichtextKey, dyScroll: -40);
      await driver.tap(Keys.jobAdditionalRequirementsRichtextKey);
      await driver.enterText('Sample Additional Requirement');
      await Future.delayed(const Duration(seconds: 2),() {});
    });

    test('Check Other Benefits', () async {
      await driver.scrollUntilVisible(Keys.singleChildScrollViewKey, Keys.otherBenefitsRichtextKey, dyScroll: -40);
      await driver.tap(Keys.otherBenefitsRichtextKey);
      await driver.enterText('Sample Other Benefits');
      await Future.delayed(const Duration(seconds: 2),() {});
    });

    test('Check Job Location', () async {
      await driver.scrollUntilVisible(Keys.singleChildScrollViewKey, Keys.jobLocationTextfieldKey, dyScroll: -40);
      await driver.tap(Keys.jobLocationTextfieldKey);
      await driver.enterText('Niketan, Road 4, Block B');
      await Future.delayed(const Duration(seconds: 2),() {});
    });

    test('Check Job Area', () async {
      await driver.scrollUntilVisible(Keys.singleChildScrollViewKey, Keys.jobAreaTextfieldKey, dyScroll: -40);
      await driver.tap(Keys.jobAreaTextfieldKey);
      await driver.enterText('Gulshan-1');
      await Future.delayed(const Duration(seconds: 2),() {});
    });

    test('Check City', () async {
      await driver.scrollUntilVisible(Keys.singleChildScrollViewKey, Keys.jobCityDropDownListKey, dyScroll: -40);
      await driver.tap(Keys.jobCityDropDownListKey);
      await driver.tap(find.text('Tangail,Bangladesh'));
      await Future.delayed(const Duration(seconds: 2),() {});
    });

    test('Check Job Site', () async {
      await driver.scrollUntilVisible(Keys.singleChildScrollViewKey, Keys.jobSiteDropDownListKey, dyScroll: -40);
      await driver.tap(Keys.jobSiteDropDownListKey);
      await driver.tap(find.text('On-site'));
      await Future.delayed(const Duration(seconds: 2),() {});
    });
    test('Check Job Nature', () async {
      await driver.scrollUntilVisible(Keys.singleChildScrollViewKey, Keys.jobNatureDropDownListKey, dyScroll: -40);
      await driver.tap(Keys.jobNatureDropDownListKey);
      await driver.tap(find.text('Full-time'));
      await Future.delayed(const Duration(seconds: 2),() {});
    });
    test('Check Job Type', () async {
      await driver.scrollUntilVisible(Keys.singleChildScrollViewKey, Keys.jobTypeDropDownListKey, dyScroll: -40);
      await driver.tap(Keys.jobTypeDropDownListKey);
      await driver.tap(find.text('Permanent'));
      await Future.delayed(const Duration(seconds: 2),() {});
    });

    test('Check About Company', () async {
      await driver.scrollUntilVisible(Keys.singleChildScrollViewKey, Keys.jobAboutCompanyTextfieldKey, dyScroll: -40);
      await driver.tap(Keys.jobAboutCompanyTextfieldKey);
      await driver.enterText('www.aboutcompany.com/about');
      await Future.delayed(const Duration(seconds: 2),() {});
    });

    test('Check draft button and confirm all data saved successfully', () async {
      await driver.tap(Keys.postJobDraftButtonKey);
      await Future.delayed(const Duration(seconds: 4),() {});
    });

  });

}
