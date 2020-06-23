import 'package:flutter/material.dart';

class ButtonWithPrimaryFillColor extends StatelessWidget {
  final String text;
  final Function onPressed;

  ButtonWithPrimaryFillColor({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}