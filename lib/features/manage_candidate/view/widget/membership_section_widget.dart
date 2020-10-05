import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/manage_candidate/models/member_ship_info.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/user_info_list_item.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';
import 'package:jobxprss_company/method_extension.dart';

class MembershipSectionWidget extends StatelessWidget {
  final List<MembershipInfo> membershipInfo;


  MembershipSectionWidget(this.membershipInfo);

  @override
  Widget build(BuildContext context) {
      return UserInfoListItem(
      icon: FontAwesomeIcons.users,
      label: StringResources.membershipsText,
      children: List.generate(membershipInfo.length, (index) {
        var memberShip = membershipInfo[index];
        return MemberShipListItem(
          memberShip: memberShip,

        );
      }),
    );

  }
}

class MemberShipListItem extends StatefulWidget {
  final MembershipInfo memberShip;
  MemberShipListItem({
    Key key,
    @required this.memberShip
  }) : super(key: key);

  @override
  _MemberShipListItemState createState() => _MemberShipListItemState();
}

class _MemberShipListItemState extends State<MemberShipListItem> {
  bool expandable(){
    if(widget.memberShip.description.htmlToNotusDocument.toPlainText().length>1){
      return true;
    }
    return false;
  }

  String date(){
    String expDate = !widget.memberShip.membershipOngoing?"- ${DateFormatUtil().dateFormat1(widget.memberShip.endDate)}":'';
    String issueDate = widget.memberShip.startDate!=null?"${DateFormatUtil().dateFormat1(widget.memberShip.startDate)} ":"";
    return issueDate+expDate;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,
      ),
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: widget.memberShip?.organization?.image??"",
                height: 60,
                width: 60,
                placeholder: (v,i)=>    Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.certificate,
                      size: 30,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.memberShip.orgName ?? "",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.memberShip.positionHeld ?? "",),
                        SizedBox(height: 5,),
                        Text(
                          date(),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          expandable()?ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: null,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: Alignment.centerLeft,
            children: [
              HtmlWidget(widget.memberShip.description),
              SizedBox(height: 7,)
            ],
          ):SizedBox()
        ],
      ),
    );
  }

  Widget _item(
      {@required BuildContext context,
        @required String label,
        @required String value,
        @required Key valueKey}) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text("$label: ",style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text("${value ?? ""}", key: valueKey,)),
        ],),
    );
  }
}
