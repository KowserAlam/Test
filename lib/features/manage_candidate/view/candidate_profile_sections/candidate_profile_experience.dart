import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/manage_candidate/models/experience_info.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/candidate_profile_tile.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/user_info_list_item.dart';

class Experience extends StatelessWidget {
  final List<ExperienceInfo> experienceInfoList;
  Experience({this.experienceInfoList});

  @override
  Widget build(BuildContext context) {

    return UserInfoListItem(
        icon: FontAwesomeIcons.globe,
        label: 'Work Experience',
        children: List.generate(experienceInfoList.length, (int index) {
          var exp = experienceInfoList[index];
          return CandidateProfileTile(
            experienceInfo: exp,
          );
        }));
  }
}
