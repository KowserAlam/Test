import 'package:flutter/material.dart';

class CommonStyleTextField {
  static List<BoxShadow> boxShadow = [
    BoxShadow(color: Color(0xff000000).withOpacity(0.2), blurRadius: 5),
    BoxShadow(color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 5),
  ];

  static var borderRadiusRound = BorderRadius.circular(25);

  static focusedBorder(context) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(color: Theme.of(context).primaryColor));

  static focusedBorderRound(context) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: Theme.of(context).primaryColor));
}
