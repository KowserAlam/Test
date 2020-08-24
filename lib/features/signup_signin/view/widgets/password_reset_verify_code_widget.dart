
import 'package:jobxprss_company/features/signup_signin/view_models/password_reset_view_model.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:jobxprss_company/main_app/views/widgets/common_button.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:jobxprss_company/main_app/views/verification_code_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PasswordResetVerifyCodeWidget extends StatefulWidget {
  final Function onSuccessCallBack;

  PasswordResetVerifyCodeWidget({this.onSuccessCallBack});

  @override
  _PasswordResetVerifyCodeWidgetState createState() =>
      _PasswordResetVerifyCodeWidgetState();
}

class _PasswordResetVerifyCodeWidgetState
    extends State<PasswordResetVerifyCodeWidget> {
  final FocusNode _codeFocusNode = FocusNode();

  _handleVerify() async {
    var passwordResetProvider = Provider.of<PasswordResetViewModel>(context);

    if (true) {
      /// on success navigating to next page
      passwordResetProvider.isCodeResend = true;
      widget.onSuccessCallBack();
    }
  }

  Widget _logoWidget() => Icon(
        FontAwesomeIcons.lock,
        size: 50,
      );

  Widget _headingWidget() => Text(
        StringResources.resetYourPassword,
        style: Theme.of(context).textTheme.display1,
      );

  Widget _resetInformationWidget() => Column(
        children: <Widget>[
          Text(
            StringResources.an6DigitCodeSentToText,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Consumer<PasswordResetViewModel>(
              builder: (context, passwordResetProvider, _) {
            return Text(
              passwordResetProvider.passwordResetMethodIsEmail?"example@email.com":"+8801XXXXXXXXXXXX",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            );
          }),
        ],
      );

  Widget _codeVerificationInput() => VerificationCodeInput(
    inputFieldBackgroundColor: Theme.of(context).backgroundColor,
        keyboardType: TextInputType.number,
        length: 6,
        autofocus: true,
        onCompleted: (String value) {
          _handleVerify();
          logger.i(value);
        },
      );

  Widget _resendCodeWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(StringResources.didNotReceiveTheCodeText,
              style: TextStyle(
                fontSize: 16,
              )),
          SizedBox(
            width: 5,
          ),
          Consumer<PasswordResetViewModel>(
              builder: (context, passwordResetProvider, _) {
            if (passwordResetProvider.isCodeResend) {
              return Text(StringResources.resendText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 16,
                  ));
            }
            return InkWell(
              onTap: () {
//                          signUpProvider.checkingEmail(signUpProvider.email);
//                          signUpProvider.isCodeResend = true;
              },
              child: Text(StringResources.resendText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
            );
          })
        ],
      );

  @override
  Widget build(BuildContext context) {
    double width =
        MediaQuery.of(context).size.width > 720 ? 500 : double.infinity;
    return Center(
      child: Container(
        width: width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                _logoWidget(),
                SizedBox(
                  height: 10,
                ),
                _headingWidget(),
                SizedBox(height: 16),
                _resetInformationWidget(),
                SizedBox(height: 15),
                _codeVerificationInput(),
                SizedBox(height: 15),
                _resendCodeWidget(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
