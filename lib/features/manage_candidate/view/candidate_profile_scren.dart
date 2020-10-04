import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/candidate_profile_header.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/certifications_section_widget.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/education_section_widget.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/experience_section_widget.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/membership_section_widget.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/personal_info_widget.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/portfolio_section.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/reference_section_widget.dart';
import 'package:jobxprss_company/features/manage_candidate/view/widget/skill_section_widget.dart';
import 'package:jobxprss_company/features/manage_candidate/view_models/candidate_profile_view_model.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';
import 'package:jobxprss_company/main_app/util/common_style_text_field.dart';
import 'package:jobxprss_company/main_app/views/widgets/page_state_builder.dart';

class CandidateProfileScreen extends StatefulWidget {
  final String slug;

  CandidateProfileScreen(this.slug);

  @override
  _CandidateProfileScreenState createState() => _CandidateProfileScreenState();
}

class _CandidateProfileScreenState extends State<CandidateProfileScreen> {
  CandidateProfileViewModel vm;
  var spaceBetweenSectionSizedBox = SizedBox(
    height: 16,
  );

  @override
  void initState() {
    Get.put(CandidateProfileViewModel(), tag: widget.slug);
    vm = Get.find<CandidateProfileViewModel>(tag: widget.slug);
    vm.getCandidateInfo(widget.slug);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Obx(() => Text(vm.candidate.value?.personalInfo?.fullName ?? "")),
      ),
      body: Obx(() => PageStateBuilder(
            appError: vm.appError.value,
            showError: vm.shouldShowError,
            showLoader: vm.shouldShowPageLoader,
            onRefresh: () {
              return vm.getCandidateInfo(widget.slug);
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  UserProfileHeader(vm.candidate.value),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        spaceBetweenSectionSizedBox,
                        ExperienceSectionWidget(vm.candidate.value.experienceInfo),
                        spaceBetweenSectionSizedBox,
                        EducationSectionWidget(vm.candidate.value.eduInfo),
                        spaceBetweenSectionSizedBox,
                        SkillSectionWidget(vm.candidate.value.skillInfo),
                        spaceBetweenSectionSizedBox,
                        PortfolioSection(vm.candidate.value.portfolioInfo),
                        spaceBetweenSectionSizedBox,
                        CertificationsSectionWidget(
                            vm.candidate.value.certificationInfo),
                        spaceBetweenSectionSizedBox,
                        MembershipSectionWidget(
                            vm.candidate.value.membershipInfo),
                        spaceBetweenSectionSizedBox,
                        ReferenceSection(vm.candidate.value.referenceData),
                        spaceBetweenSectionSizedBox,
                        PersonalInfoWidget(vm.candidate.value.personalInfo),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
