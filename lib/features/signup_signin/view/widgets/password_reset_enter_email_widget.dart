

import 'package:jobxprss_company/features/signup_signin/view/widgets/title_widget.dart';
import 'package:jobxprss_company/features/signup_signin/view_models/password_reset_view_model.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/common_button.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Enter email page

class PasswordResetEmailWidget extends StatefulWidget {
  final Function onSuccessCallBack;

  PasswordResetEmailWidget({this.onSuccessCallBack});

  @override
  _PasswordResetEmailWidgetState createState() =>
      _PasswordResetEmailWidgetState();
}

class _PasswordResetEmailWidgetState extends State<PasswordResetEmailWidget> {
  final _emailTextController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  Widget _logoSection() {
    return Center(
      child: Hero(
        tag: kDefaultLogo,
        child: Image.asset(
          kDefaultLogo,
          width: 100,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _titleText() {
    return TitleWidget(
      labelText: StringResources.passwordResetText,
    );
  }

  Widget _inputTypeSelectionItemWidget(
          {@required bool value,
          bool groupValue = true,
          @required Function(bool value) onChanged,
          @required String label}) =>
      Row(
        children: <Widget>[
          Radio(
            onChanged: onChanged,
            groupValue: groupValue,
            value: value,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 17),
          ),
        ],
      );

  Widget _passwordResetMethodWidget(context) => Consumer<PasswordResetViewModel>(
          builder: (context, passwordResetProvider, _) {
        return Row(
          children: <Widget>[
            _inputTypeSelectionItemWidget(
                label: StringResources.emailText,
                onChanged: (value) {
                  /// Email
                  passwordResetProvider.passwordResetMethodIsEmail = true;
                  _emailFocus.unfocus();
                  _emailTextController.clear();
                },
                value: passwordResetProvider.passwordResetMethodIsEmail),
            SizedBox(
              width: 10,
            ),
            _inputTypeSelectionItemWidget(
                groupValue: false,
                label: StringResources.smsText,
                onChanged: (value) {
                  /// Phone
                  passwordResetProvider.passwordResetMethodIsEmail = false;
                  _emailTextController.clear();
                  _emailFocus.unfocus();
                },
                value: passwordResetProvider.passwordResetMethodIsEmail),
          ],
        );
      });

  Widget _proceedButton({bool enabled}) {
    var passwordResetProvider = Provider.of<PasswordResetViewModel>(context);
    return Center(
      child: passwordResetProvider.isBusyEmail
          ? Loader()
          : CommonButton(
              width: 230,
              height: 50,
              onTap: !enabled? null: () {
                _handleEmailSubmit(_emailTextController.text, context);
              },
              label: StringResources.passwordResetText,
            ),
    );
  }

  _handleEmailSubmit(String email, context) async {
    var isSuccess =  await Provider.of<PasswordResetViewModel>(context,listen: false).sendResetPasswordLink();
    if (isSuccess) {
      widget.onSuccessCallBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width =
        MediaQuery.of(context).size.width > 720 ? 500 : double.infinity;

    var passwordResetProvider = Provider.of<PasswordResetViewModel>(context);
    var hintText = passwordResetProvider.passwordResetMethodIsEmail
        ? StringResources.emailText
        : StringResources.phoneText;
    var iconPrefix = passwordResetProvider.passwordResetMethodIsEmail
        ? Icons.mail
        : Icons.phone_android;
    var keyboardType = passwordResetProvider.passwordResetMethodIsEmail
        ? TextInputType.emailAddress
        : TextInputType.phone;

    return Center(
      child: Container(
        width: width,
        child: ListView(
          padding: EdgeInsets.all(20),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            _logoSection(),
            SizedBox(height: 10),
            _titleText(),
            SizedBox(height: 20),
            Consumer<PasswordResetViewModel>(
                builder: (context, passwordResetViewModel ,_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: CommonStyle.boxShadow,
                            borderRadius:
                                CommonStyle.borderRadiusRound,
                            color: Theme.of(context).backgroundColor),
                        child: TextField(
                          keyboardType: keyboardType,
                          onChanged: passwordResetViewModel.validateEmailLocal,
                          focusNode: _emailFocus,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (email) {
                            _handleEmailSubmit(email, context);
                          },
                          controller: _emailTextController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              hintText: hintText,
                              focusedBorder:
                                  CommonStyle.focusedBorderRound(
                                      context),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).backgroundColor)),
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                iconPrefix,
                              )),
                        ),
                      ),
                      if (passwordResetViewModel.emailErrorText != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 20,right: 20),
                          child: Text(
                            " ${passwordResetViewModel.emailErrorText}",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      SizedBox(height: 20),
                      _proceedButton(enabled: passwordResetViewModel.shodAllowProceedButton),
                    ],
                  );
                }),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
