import 'package:bot_toast/bot_toast.dart';
import 'package:jobxprss_company/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:jobxprss_company/features/signup_signin/view/signin_screen.dart';
import 'package:jobxprss_company/features/signup_signin/view_models/singin_view_model.dart';
import 'package:jobxprss_company/features/signup_signin/view_models/password_change_view_model.dart';
import 'package:jobxprss_company/features/signup_signin/view_models/password_reset_view_model.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:jobxprss_company/main_app/root.dart';
import 'package:jobxprss_company/main_app/util/common_serviec_rule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobExpressCompanyApp extends StatelessWidget {
  final isEnabledDevicePreview;
  final CommonServiceRule commonServiceRule = CommonServiceRule();

  JobExpressCompanyApp(Key key, {this.isEnabledDevicePreview = false});

  @override
  Widget build(BuildContext context) {
    var providers = [
      ChangeNotifierProvider(create: (context) => SigninViewModel()),
      ChangeNotifierProvider(create: (context) => PasswordResetViewModel()),
      ChangeNotifierProvider(create: (context) => PasswordChangeViewModel()),
      ChangeNotifierProvider(create: (context) => DashboardViewModel()),
    ];
    var appName = FlavorConfig.appName();

    return MultiProvider(
      key: key,
      providers: providers,
      child: MaterialApp(
        navigatorObservers: [BotToastNavigatorObserver()],
        builder: BotToastInit(),
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: AppTheme.lightTheme,
//      darkTheme: AppTheme.darkTheme,
        home: Root(),
      ),
    );
  }
}
