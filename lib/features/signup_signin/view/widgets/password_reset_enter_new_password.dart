

import 'package:jobxprss_company/features/signup_signin/view_models/password_reset_view_model.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/app_theme/comon_styles.dart';
import 'package:jobxprss_company/main_app/resource/json_keys.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/validator.dart';
import 'package:jobxprss_company/main_app/views/widgets/app_logo.dart';
import 'package:jobxprss_company/main_app/views/widgets/common_button.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class PasswordRestEnterNewPassword extends StatefulWidget {
  @override
  _PasswordRestEnterNewPasswordState createState() => _PasswordRestEnterNewPasswordState();
}

class _PasswordRestEnterNewPasswordState extends State<PasswordRestEnterNewPassword> {
  final _fullNameTextController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  final FocusNode _fullNamePasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > 720 ? 500 : double.infinity;
    return Center(
      child: Container(
        width: width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  AppLogo(size: 80,),

                  SizedBox(
                    height: 20,
                  ),
                  Consumer<PasswordResetViewModel>(builder: (context, signUpProvider, _) {
                    return TextFormField(
                      autofocus: true,
                      focusNode: _passwordFocus,
                      textInputAction: TextInputAction.next,
                      obscureText: signUpProvider.isObscurePassword,
                      controller: _passwordTextController,
                      onFieldSubmitted: (s) {
                        FocusScope.of(context)
                            .requestFocus(_confirmPasswordFocus);
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: !signUpProvider.isObscurePassword
                                ? Icon(
                              Icons.visibility,
                            )
                                : Icon(
                              Icons.visibility_off,
                              color: Theme.of(context).textTheme.body1.color,
                            ),
                            onPressed: () {
                              signUpProvider.isObscurePassword =
                              !signUpProvider.isObscurePassword;
                            },
                          )),
                      onSaved: (val) {},
                      validator: Validator().validatePassword,
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Consumer<PasswordResetViewModel>(
                        builder: (context, passwordResetProvider, _) {
                          return TextFormField(
//                            obscureText: signUpProvider.isObscureConfirmPassword,
                            focusNode: _confirmPasswordFocus,
                            textInputAction: TextInputAction.done,
                            controller: _confirmPasswordController,
                            onFieldSubmitted: (s) {
                              _confirmPasswordFocus.unfocus();
//                              _handleSignUp(context);
                            },
                            decoration: InputDecoration(
                                hintText: StringResources.confirmPasswordText,
                                suffixIcon: IconButton(
                                  icon: !passwordResetProvider.isObscureConfirmPassword
                                      ? Icon(
                                    Icons.visibility,
                                  )
                                      : Icon(
                                    Icons.visibility_off,
                                    color:
                                    Theme.of(context).textTheme.body1.color,
                                  ),
                                  onPressed: () {
                                    passwordResetProvider.isObscureConfirmPassword =
                                    !passwordResetProvider.isObscureConfirmPassword;
                                  },
                                )),
                            onSaved: (val) {
//                              _handleSignUp(context);
                            },
                            validator: (v) {
                              return Validator().validateConfirmPassword(
                                  _passwordTextController.text, v);
                            },
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<PasswordResetViewModel>(builder: (context, passwordResetProvider, _) {
                    return Center(
                      child: passwordResetProvider.isBusyConfirmation
                          ? Loader()
                          : CommonButton(
                        width: 220,
                        onTap: () {

                        },
                        label: StringResources.setNewPasswordText,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
