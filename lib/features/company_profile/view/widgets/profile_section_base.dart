import 'package:flutter/material.dart';
class ProfileSectionBase extends StatelessWidget {
  final Widget sectionBody;
  final IconData sectionIcon;
  final String sectionLabel;

  ProfileSectionBase({
    @required this.sectionBody,
    this.sectionIcon,
    this.sectionLabel,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle sectionTitleFont =
    TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    Color sectionColor = Theme.of(context).backgroundColor;
    double fontAwesomeIconSize = 15;
    double iconSize = 14;
    double sectionIconSize = 20;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: sectionColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3), topRight: Radius.circular(3))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sectionIcon != null || sectionLabel != null)
            Row(
              children: <Widget>[
                Icon(
                  sectionIcon,
                  size: fontAwesomeIconSize,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  sectionLabel,
                  style: sectionTitleFont,
                )
              ],
            ),
          SizedBox(
            height: 5,
          ),
          if (sectionBody != null) sectionBody
        ],
      ),
    );
  }
}