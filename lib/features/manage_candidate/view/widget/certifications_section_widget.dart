import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/manage_candidate/models/certification_info.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/user_info_list_item.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';

class CertificationsSectionWidget extends StatelessWidget {
  final List<CertificationInfo> certificationInfo;

  CertificationsSectionWidget(this.certificationInfo);

  @override
  Widget build(BuildContext context) {
    return UserInfoListItem(
      icon: FontAwesomeIcons.certificate,
      label: StringResources.certificationsText,
      children: List.generate(certificationInfo.length, (index) {
        var cer = certificationInfo[index];
        return CertificationsListItemWidget(
          certificationInfo: cer,
        );
      }),
    );
  }
}

class CertificationsListItemWidget extends StatefulWidget {
  final CertificationInfo certificationInfo;

  const CertificationsListItemWidget({
    Key key,
    this.certificationInfo,
  }) : super(key: key);

  @override
  _CertificationsListItemWidgetState createState() => _CertificationsListItemWidgetState();
}

class _CertificationsListItemWidgetState extends State<CertificationsListItemWidget> {
  bool expandable(){
    if(widget.certificationInfo.credentialId!=null || widget.certificationInfo.credentialUrl!=null){
      return true;
    }
    return false;
  }

  String date(){
    String expDate = widget.certificationInfo.hasExpiryPeriod?"- ${DateFormatUtil().dateFormat1(widget.certificationInfo.expiryDate)}":'';
    String issueDate = widget.certificationInfo.issueDate!=null?"${DateFormatUtil().dateFormat1(widget.certificationInfo.issueDate)} ":"";
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
              imageUrl: widget.certificationInfo?.organization?.image ?? "",
                height: 60,
                width: 60,
                placeholder: (v, i) => Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.certificate,
                      size: 45,
                      color: Colors.grey[400],
                    ),
                  ),
                )),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.certificationInfo.certificationName ?? "",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.certificationInfo.organizationName ?? "",),
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
              if(widget.certificationInfo.credentialUrl!=null)_item(context: context, label: StringResources.certificationCredentialUrlText, value: widget.certificationInfo.credentialUrl, valueKey: null),
              if(widget.certificationInfo.credentialId!=null)_item(context: context, label: StringResources.certificationCredentialIdText, value: widget.certificationInfo.credentialId, valueKey: null),
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
