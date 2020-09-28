import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jobxprss_company/features/manage_candidate/models/experience_info.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';

class CandidateProfileTile extends StatefulWidget {
  final ExperienceInfo experienceInfo;
  CandidateProfileTile({this.experienceInfo});
  @override
  _CandidateProfileTileState createState() => _CandidateProfileTileState();
}

class _CandidateProfileTileState extends State<CandidateProfileTile> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 0),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                imageUrl: widget.experienceInfo.companyProfilePic ?? "",
              ),
            ],
          )
        ],
      ),
    );
  }
}
