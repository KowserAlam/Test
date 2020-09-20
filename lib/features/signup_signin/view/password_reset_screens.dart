import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/signup_signin/view/widgets/password_reset_enter_email_widget.dart';
import 'package:jobxprss_company/features/signup_signin/view/widgets/password_rest_link_success_widget.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class PasswordResetScreens extends StatefulWidget {
  @override
  _PasswordResetScreensState createState() => _PasswordResetScreensState();
}

class _PasswordResetScreensState extends State<PasswordResetScreens> {
  PageController _pageController = PageController();
  var _valueNotifier = ValueNotifier<int>(0);
  int index = 0;
  int length = 2;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(StringResources.passwordResetText, key: Key('passwordResetScreenAppBarTitleKey'),),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  onPageChanged: (i) {
                    _valueNotifier.value = i;
                    index = i;
                  },
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    PasswordResetEmailWidget(
                      onSuccessCallBack: () {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut);
                      },
                    ),
                    PasswordRestLinkSuccessWidget(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CirclePageIndicator(
                  dotColor: Theme.of(context).primaryColor.withOpacity(0.25),
                  selectedDotColor: Theme.of(context).primaryColor,
                  selectedSize: 10,
                  itemCount: length,
                  currentPageNotifier: _valueNotifier,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
