import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys.dart';


main(){
  dashboardTest();
}
Future<void> dashboardTest()async{

  group('Dashboard Test', () {

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
    test('Check Jobs Posted inbox button', () async {
      await driver.tap(Keys.infoboxJobsPostedTextKey);
      await Future.delayed(const Duration(seconds: 4),() {});
      await driver.tap(Keys.bottomNavBarDashboardKey);
    });

    test('Check Applications inbox button', () async {
      await driver.tap(Keys.infoboxApplicationsTextKey);
      await Future.delayed(const Duration(seconds: 4),() {});
      await driver.tap(Keys.bottomNavBarDashboardKey);
    });

    test('Check Shortlisted inbox button', () async {
      await driver.tap(Keys.infoboxShortListedTextKey);
      await Future.delayed(const Duration(seconds: 4),() {});
      await driver.tap(Keys.bottomNavBarDashboardKey);
    });


  });

}
