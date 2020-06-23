import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:flutter/material.dart';

class EditScreenSaveButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  EditScreenSaveButton({
    @required this.onPressed,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text??"",style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
