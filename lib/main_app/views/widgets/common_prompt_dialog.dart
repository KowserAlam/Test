import 'package:flutter/material.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';

class CommonPromptDialog extends StatelessWidget {
  final String titleText;
  final Function onCancel;
  final Function onAccept;

  @override
  Widget build(BuildContext context) {
//    var accentColor = Theme.of(context).accentColor;
    var buttonTextStyles = TextStyle(color: Colors.black);

    return AlertDialog(
      title: Text(titleText),
      actions: [
        FlatButton(
          key: Key('myProfileDialogBoxCancelDeleteTile'),
          color: Theme.of(context).accentColor,
          onPressed: onCancel,
          child: Text(StringResources.noText, style: buttonTextStyles),
        ),
        SizedBox(
          width: 8,
        ),
        FlatButton(
          key: Key('myProfileDialogBoxDeleteTile'),
          color: Theme.of(context).accentColor,
          onPressed: onAccept,
          child: Text(
            StringResources.yesText,
            style: buttonTextStyles,
          ),
        ),
      ],
    );
  }

  const CommonPromptDialog({
    @required this.titleText,
    @required this.onCancel,
    @required this.onAccept,
  });
}
