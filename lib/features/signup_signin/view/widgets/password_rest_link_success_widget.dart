import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/signup_signin/view_models/password_reset_view_model.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/views/widgets/common_button.dart';
import 'package:provider/provider.dart';

class PasswordRestLinkSuccessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(StringResources.aPasswordRestLinkHasBeenSentToText),
      SizedBox(height: 10,),
      Consumer<PasswordResetViewModel>(
        builder: (context,passwordResetViewModel,_) {
          return Text(passwordResetViewModel.email??"",style: TextStyle(fontWeight: FontWeight.bold),);
        }
      ),
        SizedBox(height: 10,),
        CommonButton(label: StringResources.backText,onTap: (){Navigator.pop(context);},),
      ],
    ),);
  }
}
