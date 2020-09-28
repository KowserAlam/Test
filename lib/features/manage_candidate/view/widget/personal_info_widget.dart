import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/manage_candidate/models/user_personal_info.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/user_info_list_item.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';
import 'package:provider/provider.dart';

class PersonalInfoWidget extends StatelessWidget {

  final UserPersonalInfo personalInfo;


  PersonalInfoWidget(this.personalInfo);

  Widget _item(
      {@required BuildContext context,
      @required String label,
      @required String value,
      @required Key valueKey}) {
//    double width = MediaQuery.of(context).size.width > 720 ? 160 : 130;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment:CrossAxisAlignment.start,
          children: [
        Text("$label: ",style: TextStyle(fontWeight: FontWeight.bold)),
        Expanded(child: Text("${value ?? ""}", key: valueKey,)),
      ],),
    );
//    return Padding(
//      padding: const EdgeInsets.all(5.0),
//      child: Text.rich(TextSpan(children: [
//        TextSpan(
//          text: "$label",
//          style: TextStyle(fontWeight: FontWeight.bold),
//        ),
//        TextSpan(text: ": ${value ?? ""}"),
//      ])),
//    );

  }

  Widget _htmlItem(
      {@required BuildContext context,
        @required String label,
        @required String value,
        @required Key valueKey}) {
//    double width = MediaQuery.of(context).size.width > 720 ? 160 : 130;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text("$label: ",style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: HtmlWidget("${value ?? ""}", key: valueKey,)),
        ],),
    );
//    return Padding(
//      padding: const EdgeInsets.all(5.0),
//      child: Text.rich(TextSpan(children: [
//        TextSpan(
//          text: "$label",
//          style: TextStyle(fontWeight: FontWeight.bold),
//        ),
//        TextSpan(text: ": ${value ?? ""}"),
//      ])),
//    );

  }

  @override
  Widget build(BuildContext context) {
    return UserInfoListItem(
      icon: FontAwesomeIcons.infoCircle,
      label: StringResources.personalInfoText,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: CommonStyle.boxShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              //dob
              _item(
                  context: context,
                  valueKey: Key('personalInfoTileDateOfBirth'),
                  label: StringResources.dateOfBirthText,
                  value: personalInfo.dateOfBirth != null
                      ? DateFormatUtil.formatDate(personalInfo.dateOfBirth)
                      : ""),
              //gender
              _item(
                  context: context,
                  valueKey: Key('personalInfoTileGender'),
                  label: StringResources.genderText,
                  value: personalInfo.gender ?? ""),
              //father name
              _item(
                  context: context,
                  valueKey: Key('personalInfoTileFatherName'),
                  label: StringResources.fatherNameText,
                  value: personalInfo.fatherName ?? ""),
              //mother name
              _item(
                  context: context,
                  valueKey: Key('personalInfoTileMotherName'),
                  label: StringResources.motherNameText,
                  value: personalInfo.motherName ?? ""),

              //current address
              _htmlItem(
                  context: context,
                  valueKey: Key('personalInfoTileCurrentAddress'),
                  label: StringResources.addressText,
                  value: personalInfo.address ?? ""),
              //permanent address
              _htmlItem(
                  context: context,
                  valueKey: Key('personalInfoTilePermanentAddress'),
                  label: StringResources.permanentAddressText,
                  value: personalInfo.permanentAddress ?? ""),
              //nationality
              _item(
                  context: context,
                  valueKey: Key('personalInfoTileNationality'),
                  label: StringResources.nationalityText,
                  value: personalInfo.nationalityObj?.name ?? ""),
              //religion
              _item(
                  context: context,
                  valueKey: Key('personalInfoTileReligion'),
                  label: StringResources.religionText,
                  value: personalInfo.religionObj?.name ?? ""),
              _item(
                  context: context,
                  valueKey: Key('personalInfoTileBloodGroup'),
                  label: StringResources.bloodGroupText,
                  value: personalInfo.bloodGroup ?? ""),
            ],
          ),
        )
      ],
    );
  }
}
