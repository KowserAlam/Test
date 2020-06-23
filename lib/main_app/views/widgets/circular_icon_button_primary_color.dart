import 'package:flutter/material.dart';


class CircularIconButtonPrimaryColor extends StatelessWidget {
  final Function onPressed;
  final IconData iconData;
  const CircularIconButtonPrimaryColor({
    @required this.onPressed,
    @required this.iconData
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: RawMaterialButton(
          elevation: 20,
          constraints: BoxConstraints(
              maxHeight: 70,
              maxWidth: 70
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Theme.of(context).primaryColor,width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(iconData,size: 33,color:Theme.of(context).primaryColor ,),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}