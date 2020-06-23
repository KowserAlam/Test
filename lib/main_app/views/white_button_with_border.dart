import 'package:flutter/material.dart';
class WhiteButtonWithBorder extends StatelessWidget {
  final Function onPressed;
  final String text;

  const WhiteButtonWithBorder({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey[400], width: 2)),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 7.0),
          child: Text(
            text,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ),
    );
  }
}