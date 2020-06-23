import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String labelText ;


  TitleWidget({@required this.labelText});

  @override
  Widget build(BuildContext context) {

  return Container(
    alignment: Alignment.center,
      height: 50,
      padding: EdgeInsets.only(top: 15),
      child: Text(
        labelText,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17),
      ));

  }
}
