import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobxprss_company/features/manage_candidate/models/skill_info.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/user_info_list_item.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';

class SkillSectionWidget extends StatelessWidget {
  final List<SkillInfo> skillInfo;


  SkillSectionWidget(this.skillInfo);

  @override
  Widget build(BuildContext context) {
    return UserInfoListItem(

      icon: FontAwesomeIcons.tools,
      label: StringResources.professionalSkillText,
      children: List.generate(skillInfo.length, (index) {
        var skill = skillInfo[index];
        return ProfessionalSkillListItem(
          skillInfo: skill,

        );
      }),
    );
  }
}



class ProfessionalSkillListItem extends StatelessWidget {
  final SkillInfo skillInfo;

  ProfessionalSkillListItem(
      {Key key,
        @required this.skillInfo,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleStyle = Theme.of(context)
        .textTheme
        .subtitle2
        .apply();
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: skillInfo.verifiedBySkillCheck ?? false
                  ? Icon(
                FontAwesomeIcons.checkCircle,
                color: Colors.orange,
                size: 17,
              )
                  : Icon(
                FontAwesomeIcons.circle,
                color: Colors.orange,
                size: 17,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                skillInfo?.skill?.name ?? "",
                style: titleStyle,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  skillInfo.rating == null
                      ? "N/A"
                      : skillInfo.rating.toString() + "/10",
                  style: titleStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
