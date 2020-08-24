import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';


class NoMessagesWidget extends StatelessWidget {
  final onTap;
  const NoMessagesWidget({
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    var color = Colors.grey;

    return Container(
      height: MediaQuery.of(context).size.height - (AppBar().preferredSize.height *2),
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: onTap,
        child: Center(child: Column(
          mainAxisSize:MainAxisSize.min ,children: [
          Icon(FontAwesomeIcons.solidEnvelope,color: color,size: 40,),
          SizedBox(height: 15,),
          Text(StringResources.youDoNotHaveAnyMessage,style: TextStyle(color: color),)
        ],),),
      ),
    );
  }


}
