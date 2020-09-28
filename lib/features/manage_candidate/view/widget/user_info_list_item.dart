import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';

class UserInfoListItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final List<Widget> children;


  UserInfoListItem({
    @required this.icon,
    @required this.label,
    @required this.children,
  });

  @override
  _UserInfoListItemState createState() => _UserInfoListItemState();
}

class _UserInfoListItemState extends State<UserInfoListItem> {
  @override
  Widget build(BuildContext context) {
    var titleTextStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              widget.icon,
              size: 15,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(child: Text(widget.label, style: titleTextStyle)),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.children.length,
          itemBuilder: (c, i) => widget.children[i],
        ),
      ],
    );
  }
}
