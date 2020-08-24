import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/onboarding_page/onboarding_page.dart';
import 'package:jobxprss_company/features/signup_signin/view/signin_screen.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_user_model.dart';
import 'package:jobxprss_company/main_app/home.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/util/local_storage.dart';
import 'package:jobxprss_company/main_app/views/widgets/app_version_widget_small.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'auth_service/auth_service.dart';

class Root extends StatefulWidget {
  final bool showDummyLoadingTime;

  Root({this.showDummyLoadingTime = false});

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    var authService = await AuthService.getInstance();
//    authService.refreshToken();
    if (authService.isAccessTokenValid()) {
      debugPrint("user: ${authService.getUser()}");

      _naveGateToNextScreen(showDummyLoading: widget.showDummyLoadingTime);
    } else {
      bool isSuccess = await authService.refreshToken();
      if (isSuccess) {
        _naveGateToNextScreen();
      } else {
        _navigateToLoginScreen();
        authService.removeUser();
      }
    }
  }

  _navigateToLoginScreen() {
    Future.delayed(Duration(seconds: 1)).then((_) {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => SigninScreen()),
          (Route<dynamic> route) => false);
    });
  }

  _naveGateToNextScreen({bool showDummyLoading = false}) {
//    _setupPushNotification();
//    _initUserdata();

    Future.delayed(Duration(seconds: showDummyLoading ? 0 : 2)).then((_) async {
      if (await shouldShowOnBoardingScreens()) {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => OnboardingScreens()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false);
      }
    });
  }



  Future<bool> shouldShowOnBoardingScreens() async {
    var _storage = await LocalStorageService.getInstance();
    var val = _storage.getBool("showIntro");
    if (val == null) return true;

    return val;
  }

  Future<AuthUserModel> getAuthStatus() async {
    AuthUserModel user =
        await AuthService.getInstance().then((value) => value.getUser());

    if (user != null) {
      Logger().i(user.toJson());
    } else {
      debugPrint("User: $user");
    }
    return user;
  }

//  var appLogoText = Column(
//    mainAxisSize: MainAxisSize.min,
//    children: <Widget>[
//      Container(
//        width: 170,
//        child: Hero(
//            tag: kDefaultLogoFull,
//            child: Image.asset(
//              kDefaultLogoFull,
//              fit: BoxFit.cover,
//            )),
//      ),
//    ],
//  );

  var ishraakLogo = Image.asset(
    kIshraakLogo,
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var appLogoText = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 200,
          child: Hero(
              tag: kDefaultLogoFull,
              child: Image.asset(
                kDefaultLogoFull,
                fit: BoxFit.cover,
              )),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light
              .copyWith(statusBarColor: Theme.of(context).primaryColor),
          child: widget.showDummyLoadingTime
              ? Center(
                  child: Loader(),
                )
              : Container(
                  height: height,
                  width: width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(),
                      SizedBox(),
                      SizedBox(),
                      appLogoText,
                      SizedBox(),
                      Container(
                        width: 150,
                        child: ishraakLogo,
                      ),
                      AppVersionWidgetLowerCase()
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
