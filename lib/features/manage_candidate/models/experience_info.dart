import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:jobxprss_company/method_extension.dart';

class ExperienceInfo {
  String experienceId;
  String companyNameText;
  String companyNameId;
  String designation;
  String description;
  DateTime startDate;
  DateTime endDate;
  String companyProfilePic;
  bool isCurrentlyWorkingHere;

  ExperienceInfo({
    this.description,
    this.companyNameText,
    this.designation,
    this.startDate,
    this.endDate,
    this.companyNameId,
    this.experienceId,
    this.companyProfilePic,
    this.isCurrentlyWorkingHere,
  });

  ExperienceInfo.fromJson(Map<String, dynamic> json) {
    var baseUrl = FlavorConfig?.instance?.values?.baseUrl;

    isCurrentlyWorkingHere = json['is_currently_working'];
    experienceId = json['id']?.toString();
    companyNameText = json['company_text'];
    companyNameId = json['company_id'];
    designation = json['designation'];
    description = json['description'];
    if (json['start_date'] != null) {
      startDate = DateTime.parse(json['start_date']);
    }

    if (json['end_date'] != null) {
      endDate = DateTime.parse(json['end_date']);
    }
    if (json['company'] != null) {
      companyProfilePic = "${baseUrl}${json['company']['profile_picture']}";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.experienceId;
    data['company_text'] = this.companyNameText;
    if(this.companyNameId != null){
      data['company_id'] = this.companyNameId;
    }
    data['is_currently_working'] = this.isCurrentlyWorkingHere;
    data['designation'] = this.designation;
    data['description'] = this.description;
    data['start_date'] = this.startDate.toYYYMMDDString;
    data['end_date'] = this.endDate.toYYYMMDDString;
    return data;
  }
}
