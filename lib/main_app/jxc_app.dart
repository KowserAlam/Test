import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:jobxprss_company/features/manage_jobs/view_models/manages_jobs_view_model.dart';
import 'package:jobxprss_company/features/messaging/view_mpdel/message_sender_list_screen_view_model.dart';
import 'package:jobxprss_company/features/signup_signin/view/signin_screen.dart';
import 'package:jobxprss_company/features/signup_signin/view_models/singin_view_model.dart';
import 'package:jobxprss_company/features/signup_signin/view_models/password_change_view_model.dart';
import 'package:jobxprss_company/features/signup_signin/view_models/password_reset_view_model.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:jobxprss_company/main_app/root.dart';
import 'package:jobxprss_company/main_app/util/common_serviec_rule.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class JXCApp extends StatelessWidget {
  final isEnabledDevicePreview;
  final CommonServiceRule commonServiceRule = CommonServiceRule();

  JXCApp(Key key, {this.isEnabledDevicePreview = false});

  @override
  Widget build(BuildContext context) {
    Get.config(
      enableLog: true,
      defaultPopGesture: true,
      defaultTransition: Transition.cupertino,
      defaultOpaqueRoute: true,
      defaultDurationTransition: Duration(milliseconds: 180),
    );



    var providers = [
      ChangeNotifierProvider(create: (context) => SigninViewModel()),
      ChangeNotifierProvider(create: (context) => PasswordResetViewModel()),
      ChangeNotifierProvider(create: (context) => PasswordChangeViewModel()),
      ChangeNotifierProvider(create: (context) => DashboardViewModel()),
      ChangeNotifierProvider(create: (context) => ManageJobViewModel()),
      ChangeNotifierProvider(create: (context) => CompanyProfileViewModel()),
      ChangeNotifierProvider(
          create: (context) => MessageSenderListScreenViewModel()),
    ];
    var appName = FlavorConfig.appName();

    return MultiProvider(
      key: key,
      providers: providers,
      child: GetMaterialApp(
        navigatorObservers: [BotToastNavigatorObserver()],
        builder: BotToastInit(),
        debugShowCheckedModeBanner: false,
        title: appName,
        logWriterCallback: loggerGetX,
        theme: AppTheme.lightTheme,
//      darkTheme: AppTheme.darkTheme,
        home: Root(),
      ),
    );
  }
}
