import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'auth/login_test.dart';
import 'keys.dart';


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


  });
}
