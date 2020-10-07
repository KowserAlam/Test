import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobxprss_company/features/company_profile/view_model/company_profile_view_model.dart';
import 'package:jobxprss_company/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:jobxprss_company/features/messaging/view_model/message_sender_list_screen_view_model.dart';
import 'package:jobxprss_company/features/signup_signin/view_models/password_change_view_model.dart';
import 'package:jobxprss_company/features/signup_signin/view_models/password_reset_view_model.dart';
import 'package:jobxprss_company/features/signup_signin/view_models/singin_view_model.dart';
import 'package:jobxprss_company/main_app/app_theme/app_theme.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:jobxprss_company/main_app/root.dart';
import 'package:jobxprss_company/main_app/util/common_serviec_rule.dart';
import 'package:provider/provider.dart';

class JXCApp extends StatelessWidget {
  final CommonServiceRule commonServiceRule = CommonServiceRule();

  JXCApp(Key key) :super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.config(
      // enableLog: true,
      defaultPopGesture: true,
      defaultTransition: Transition.cupertino,
      defaultOpaqueRoute: true,
      defaultDurationTransition: Duration(milliseconds: 180),
    );

    //TODO: We are middle of changing state management Provider to GetX. Which are partially done.
    //TODO: Need to shift all those into GetX ! Because GetXBuilder is liter then ChangeNotifier!
    //TODO: Also we have advantage of context free dependency injection, Reactive State Management, Context free Navigation and more !
    var providers = [
      ChangeNotifierProvider(create: (context) => SigninViewModel()),
      ChangeNotifierProvider(create: (context) => PasswordResetViewModel()),
      ChangeNotifierProvider(create: (context) => PasswordChangeViewModel()),
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
        theme: AppTheme.lightTheme.copyWith(
          textTheme: GoogleFonts.robotoTextTheme(Theme
              .of(context)
              .textTheme),
        ),
        home: Root(),
      ),
    );
  }
}
