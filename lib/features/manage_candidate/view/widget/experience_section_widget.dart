import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/manage_candidate/models/experience_info.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/user_info_list_item.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/util/date_format_uitl.dart';

class ExperienceSectionWidget extends StatelessWidget {

  final List<ExperienceInfo> experienceInfo;


  ExperienceSectionWidget(this.experienceInfo);

  @override
  Widget build(BuildContext context) {
    return UserInfoListItem(

      icon: FontAwesomeIcons.globeEurope,
      label: StringResources.workExperienceText,

      children: List.generate(experienceInfo.length, (int index) {
        var exp = experienceInfo[index];
        return ExperienceListItem(
          experienceInfoModel: exp);
      }),
    );

  }
}

class ExperienceListItem extends StatelessWidget {
  final ExperienceInfo experienceInfoModel;

  ExperienceListItem(
      {this.experienceInfoModel});

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;

    String startDate = experienceInfoModel.startDate != null
        ? "${DateFormatUtil().dateFormat1(experienceInfoModel.startDate)} "
        : "";
    String date = "$startDate"
        "- ${experienceInfoModel.endDate == null ? "Ongoing" : DateFormatUtil().dateFormat1(experienceInfoModel.endDate)}";

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          CachedNetworkImage(
            height: 55,
            width: 55,
            fit: BoxFit.cover,
            placeholder: (context, _) => Image.asset(
              kCompanyImagePlaceholder,
              height: 55,
              width: 55,
              fit: BoxFit.cover,
            ),
            imageUrl: experienceInfoModel.companyProfilePic ?? "",
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experienceInfoModel.companyNameText ?? "",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(experienceInfoModel.designation ?? "",),
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
