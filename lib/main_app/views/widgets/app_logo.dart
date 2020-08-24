import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;


  AppLogo({this.size});

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double iconSize = size ?? iconTheme.size;
    return Image.asset(kDefaultLogoFull,height: iconSize,fit: BoxFit.cover,);
  }
}
