import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';

class Candidate {
  String applicationId;
  String fullName;
  String image;
  String applicationNotes;
  String applicationStatus;
  String applicationStatusName;
  bool isShortlisted;
  String user;
  String currentDesignation;
  String currentCompany;
  String experience;
  List<String> skills;
  String slug;

  Candidate(
      {this.applicationId,
      this.fullName,
      this.image,
      this.applicationNotes,
      this.applicationStatus,
      this.applicationStatusName,
      this.isShortlisted,
      this.user,
      this.currentDesignation,
      this.currentCompany,
      this.experience,
      this.skills,
      this.slug});

  Candidate.fromJson(Map<String, dynamic> json) {
    var baseUrl = FlavorConfig?.instance?.values?.baseUrl;
    applicationId = json['application_id']?.toString();
    fullName = json['full_name']?.toString();
    image = "$baseUrl${json['image']}";
    applicationNotes = json['application_notes']?.toString();
    applicationStatus = json['application_status']?.toString();
    applicationStatusName = json['application_status_name']?.toString();
    isShortlisted = json['is_shortlisted'] ?? false;
    user = json['user']?.toString();
    currentDesignation = json['current_designation']?.toString();
    currentCompany = json['current_company']?.toString();
    experience = json['experience']?.toString();
    if (json['skills'] != null) {
      skills = new List<String>();
      json['skills'].forEach((v) {
        skills.add(v['skill']);
      });
    }
    slug = json['slug']?.toString();
  }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['application_id'] = this.applicationId;
//    data['full_name'] = this.fullName;
//    data['image'] = this.image;
//    data['application_notes'] = this.applicationNotes;
//    data['application_status'] = this.applicationStatus;
//    data['application_status_name'] = this.applicationStatusName;
//    data['is_shortlisted'] = this.isShortlisted;
//    data['user'] = this.user;
//    data['current_designation'] = this.currentDesignation;
//    data['current_company'] = this.currentCompany;
//    data['experience'] = this.experience;
//    if (this.skills != null) {
//      data['skills'] = this.skills.map((v) => v.toJson()).toList();
//    }
//    data['slug'] = this.slug;
//    return data;
//  }
}
