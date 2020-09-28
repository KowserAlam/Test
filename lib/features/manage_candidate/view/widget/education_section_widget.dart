import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/manage_candidate/models/edu_info.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/user_info_list_item.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';

class EducationSectionWidget extends StatelessWidget {
  final List<EduInfo> eduInfo;


  EducationSectionWidget(this.eduInfo);

  @override
  Widget build(BuildContext context) {

    return UserInfoListItem(
      icon: FontAwesomeIcons.university,
      label: StringResources.educationsText,
      children: List.generate(eduInfo.length, (int i) {
        return EducationsListItem(
          eduInfoModel: eduInfo[i],
        );
      }),
    );
  }
}



class EducationsListItem extends StatelessWidget {
  final EduInfo eduInfoModel;

  EducationsListItem(
      {@required this.eduInfoModel,});

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    String graduationDateText = eduInfoModel.graduationDate != null
        ? DateFormatUtil.formatDate(eduInfoModel.graduationDate)
        : StringResources.ongoingText;
    String date =
        "${eduInfoModel.enrolledDate != null ? DateFormatUtil.formatDate(eduInfoModel.enrolledDate) : ""} - $graduationDateText";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: eduInfoModel?.institutionObj?.image??"",
            height: 61,
            width: 61,
            placeholder: (v,i)=>    Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Center(
                child: Icon(
                  FontAwesomeIcons.university,
                  size: 45,
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
                  eduInfoModel.institutionObj?.name ??
                      eduInfoModel.institutionText ??
                      "",style: Theme.of(context).textTheme.subtitle1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${eduInfoModel?.degreeText??eduInfoModel.degreeText??""}",style: TextStyle(fontSize: 13),),
                    Text(
                      date,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
