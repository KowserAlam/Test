import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/manage_candidate/view_models/candidate_profile_view_model.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';

class CandidateProfile extends StatefulWidget {
  final String slug;

  CandidateProfile(this.slug);

  @override
  _CandidateProfileState createState() => _CandidateProfileState();
}

class _CandidateProfileState extends State<CandidateProfile> {
  CandidateProfileViewModel vm;
  @override
  void initState() {
    Get.put(CandidateProfileViewModel(),tag: widget.slug);
    vm = Get.find<CandidateProfileViewModel>(tag: widget.slug);
    vm.getCandidateInfo(widget.slug);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(()=>Text(vm.candidate.value?.personalInfo?.fullName??"")),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          profileImageWidget(),
        ],),
      ),
    );
  }

  Widget profileImageWidget() => Center(
    child: Container(
      margin: EdgeInsets.only(bottom: 15, top: 8),
      // height: 65,
      // width: 65,

      decoration: BoxDecoration(
        color: Theme.of(Get.context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: CommonStyle.boxShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Obx(()=>CachedNetworkImage(
          height: 80,
          width: 80,
          fit: BoxFit.cover,
          imageUrl: vm.candidate.value.personalInfo.profileImage ??"",
          placeholder: (context, _) => Image.asset(
            kDefaultUserImageAsset,
            fit: BoxFit.cover,
            height: 65,
            width: 65,
          ),
        )),
      ),
    ),
  );
}
