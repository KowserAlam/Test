import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/signup_signin/view/widgets/custom_text_field_rounded.dart';
import 'package:jobxprss_company/features/signup_signin/view_models/password_change_view_model.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/common_button.dart';
import 'package:jobxprss_company/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _currentPasswordTextController,
      _newPasswordTextController,
      _confirmPasswordTextController;

  bool validate() {
    return _currentPasswordTextController != null &&
        _newPasswordTextController != null &&
        _confirmPasswordTextController != null;
  }

  _handleChangePassword(context) async{
    var changePassViewModel =
        Provider.of<PasswordChangeViewModel>(context, listen: false);
    var isSuccess = await changePassViewModel.changePassword();
    if(isSuccess){
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var changePassViewModel = Provider.of<PasswordChangeViewModel>(context);

    var oldPassword = Consumer<PasswordChangeViewModel>(
      builder: (context, passwordChangeViewModel, _) {
        bool isObscure = passwordChangeViewModel.isObscurePasswordOld;
        return CustomTextFieldRounded(
          labelText: StringResources.currentPasswordText,
          textFieldKey: Key('currentPasswordTextboxKey'),
          onChanged: passwordChangeViewModel.onChangeOldPassword,
          errorText: passwordChangeViewModel.errorTextOldPassword,
          prefixIcon: Icon(
              Icons.lock
          ),
          suffixIcon: IconButton(
            icon: !isObscure
                ? Icon(
              Icons.visibility,
            )
                : Icon(
              Icons.visibility_off,
              color: Theme.of(context).textTheme.body1.color,
            ),
            onPressed: () {
              passwordChangeViewModel.isObscurePasswordOld = !isObscure;
            },
          ),
          obscureText: passwordChangeViewModel.isObscurePasswordOld,
          controller: _currentPasswordTextController,
          hintText: StringResources.currentPasswordText,
        );
      },
    );
    var newPassword = Consumer<PasswordChangeViewModel>(
      builder: (context, passwordChangeViewModel, _) {
        bool isObscure = passwordChangeViewModel.isObscurePasswordNew;
        return CustomTextFieldRounded(
          labelText: StringResources.newPasswordText,
          key: Key('newPasswordTextboxKey'),
          onChanged: passwordChangeViewModel.onChangeNewPassword,
          errorText: passwordChangeViewModel.errorTextNewPassword,
          prefixIcon: Icon(
              Icons.lock
          ),
          suffixIcon: IconButton(
            icon: !isObscure
                ? Icon(
              Icons.visibility,
            )
                : Icon(
              Icons.visibility_off,
              color: Theme.of(context).textTheme.body1.color,
            ),
            onPressed: () {
              passwordChangeViewModel.isObscurePasswordNew = !isObscure;
            },
          ),
          obscureText: passwordChangeViewModel.isObscurePasswordNew,
          controller: _newPasswordTextController,
          hintText: StringResources.newPasswordText,
        );
      },
    );
//    var confirmPassword = Consumer<PasswordChangeViewModel>(
//      builder: (context, passwordChangeViewModel, _) {
//        bool isObscure = passwordChangeViewModel.isObscurePasswordConfirm;
//        return CustomTextFieldRounded(
//          labelText: StringResources.confirmPasswordText,
//          onChanged: passwordChangeViewModel.onChangeConfirmPassword,
//          errorText: passwordChangeViewModel.errorTextConfirmPassword,
//          prefixIcon: Icon(
//              Icons.lock
//          ),
//          suffixIcon: IconButton(
//            icon: !isObscure
//                ? Icon(
//              Icons.visibility,
//            )
//                : Icon(
//              Icons.visibility_off,
//              color: Theme.of(context).textTheme.body1.color,
//            ),
//            onPressed: () {
//              passwordChangeViewModel.isObscurePasswordConfirm = !isObscure;
//            },
//          ),
//          obscureText: passwordChangeViewModel.isObscurePasswordConfirm,
//          controller: _confirmPasswordTextController,
//          hintText: StringResources.confirmPasswordText,
//        );
//      },
//    );
    var submitButton = changePassViewModel.isBusy? Loader(): Container(
      height: 50,
      width: 200,
      child: CommonButton(
        onTap: changePassViewModel.allowSubmitButton
            ? () {
                _handleChangePassword(context);
              }
            : null,
        label: StringResources.submitButtonText,
        key: Key('passwordChangeSubmitButtonKey'),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.changePasswordAppbarText, key: Key('changePasswordAppbarTitle'),),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              oldPassword,
              SizedBox(
                height: 15,
              ),
              newPassword,
//              SizedBox(
//                height: 15,
//              ),
//              confirmPassword,
              SizedBox(
                height: 20,
              ),
              submitButton
            ],
          ),
        ),
      ),
    );
  }
}
