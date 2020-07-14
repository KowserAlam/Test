import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobxprss_company/features/settings/settings_view_model.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:jobxprss_company/main_app/jxc_app.dart';
import 'package:jobxprss_company/main_app/util/locator.dart';
import 'package:jobxprss_company/main_app/views/widgets/restart_widget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupLocator();

  FlavorConfig(
      flavor: Flavor.DEV,
      color: Colors.deepPurpleAccent,
      values: FlavorValues(
          baseUrl: kBaseUrDev));

  runApp(
    RestartWidget(
      child: ChangeNotifierProvider(
        create: (context) => SettingsViewModel(),
        child:JXCApp(UniqueKey()),
      ),
    ),
  );


}
