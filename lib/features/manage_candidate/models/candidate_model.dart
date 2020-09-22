import 'package:jobxprss_company/features/manage_candidate/models/certification_info.dart';
import 'package:jobxprss_company/features/manage_candidate/models/edu_info.dart';
import 'package:jobxprss_company/features/manage_candidate/models/experience_info.dart';
import 'package:jobxprss_company/features/manage_candidate/models/member_ship_info.dart';
import 'package:jobxprss_company/features/manage_candidate/models/portfolio_info.dart';
import 'package:jobxprss_company/features/manage_candidate/models/reference_data.dart';
import 'package:jobxprss_company/features/manage_candidate/models/skill_info.dart';
import 'package:jobxprss_company/features/manage_candidate/models/user_personal_info.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';

class CandidateModel {
  UserPersonalInfo personalInfo;
  List<EduInfo> eduInfo;
  List<SkillInfo> skillInfo;
  List<ExperienceInfo> experienceInfo;
  List<PortfolioInfo> portfolioInfo;
  List<MembershipInfo> membershipInfo;
  List<CertificationInfo> certificationInfo;
  List<ReferenceData> referenceData;

  CandidateModel({
    this.personalInfo,
    this.eduInfo,
    this.skillInfo,
    this.experienceInfo,
    this.portfolioInfo,
    this.membershipInfo,
    this.certificationInfo,
    this.referenceData,
  });

  CandidateModel.fromJson(Map<String, dynamic> json) {
    personalInfo = json['personal_info'] != null
        ? new UserPersonalInfo.fromJson(json['personal_info'])
        : null;
    if (json['edu_info'] != null) {
      eduInfo = new List<EduInfo>();
      json['edu_info'].forEach((v) {
        eduInfo.add(new EduInfo.fromJson(v));
      });
      eduInfo.sort((a,b){
        if(a.enrolledDate == null || b.enrolledDate == null)
          return 0;
        return b.enrolledDate.compareTo(a.enrolledDate);});

    }
    if (json['skill_info'] != null) {
      skillInfo = new List<SkillInfo>();
      json['skill_info'].forEach((v) {
        skillInfo.add(new SkillInfo.fromJson(v));
      });
    }

    if (json['experience_info'] != null) {
      experienceInfo = new List<ExperienceInfo>();
      json['experience_info'].forEach((v) {
        experienceInfo.add(new ExperienceInfo.fromJson(v));
      });

      experienceInfo.sort((a,b){
        if(a.startDate == null || b.startDate == null)
          return 0;
        return b.startDate.compareTo(a.startDate);});
    }
    if (json['portfolio_info'] != null) {
      portfolioInfo = new List<PortfolioInfo>();
      json['portfolio_info'].forEach((v) {
        portfolioInfo.add(new PortfolioInfo.fromJson(v));
      });
    }

    if (json['membership_info'] != null) {
      membershipInfo = new List<MembershipInfo>();
      json['membership_info'].forEach((v) {
        membershipInfo.add(new MembershipInfo.fromJson(v));
      });

      membershipInfo.sort((a,b){
        if(a.startDate == null || b.startDate == null)
          return 0;
        return b.startDate.compareTo(a.startDate);});
    }

    if (json['certification_info'] != null) {
      certificationInfo = new List<CertificationInfo>();
      json['certification_info'].forEach((v) {
        certificationInfo.add(new CertificationInfo.fromJson(v));
      });
    }
    if (json['reference_data'] != null) {
      referenceData = new List<ReferenceData>();
      json['reference_data'].forEach((v) {
        referenceData.add(new ReferenceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.personalInfo != null) {
      data['personal_info'] = this.personalInfo.toJson();
    }
    if (this.eduInfo != null) {
      data['edu_info'] = this.eduInfo.map((v) => v.toJson()).toList();
    }
    if (this.skillInfo != null) {
      data['skill_info'] = this.skillInfo.map((v) => v.toJson()).toList();
    }
    if (this.experienceInfo != null) {
      data['experience_info'] =
          this.experienceInfo.map((v) => v.toJson()).toList();
    }
    if (this.portfolioInfo != null) {
      data['portfolio_info'] =
          this.portfolioInfo.map((v) => v.toJson()).toList();
    }
    if (this.membershipInfo != null) {
      data['membership_info'] =
          this.membershipInfo.map((v) => v.toJson()).toList();
    }
    if (this.certificationInfo != null) {
      data['certification_info'] =
          this.certificationInfo.map((v) => v.toJson()).toList();
    }
    if (this.referenceData != null) {
      data['reference_data'] =
          this.referenceData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
