

import 'package:jobxprss_company/features/manage_candidate/models/major.dart';

import 'institution.dart';
import 'package:jobxprss_company/method_extension.dart';

class EduInfo {
  bool isOnGoing;
  int educationId;
  String degree;
  String degreeText;
  String educationLevel;
  int institutionId;
  String institutionText;
  String cgpa;
  MajorSubject major;
  String majorText;
  DateTime enrolledDate;
  DateTime graduationDate;
  String description;
  Institution institutionObj;


  EduInfo(
      {this.educationId,
      this.educationLevel,
      this.degree,
      this.institutionId,
      this.institutionText,
        this.degreeText,
      this.cgpa,
      this.major,
      this.majorText,
      this.enrolledDate,
      this.graduationDate,
      this.description,
      this.isOnGoing,
      this.institutionObj});

  EduInfo.fromJson(Map<String, dynamic> json) {
    isOnGoing = json['is_ongoing']??false;
    educationId = json['id'];
    degree = json['degree'];
    degreeText = json['degree_text'];
    educationLevel = json['education_level']?.toString();
    description = json['description'];
    institutionId = json['institution_id'];
    institutionText = json['institution_text'];
    cgpa = json['cgpa'];

    if (json['major_obj'] != null) {
      major = json['major_obj']['id'] == null
          ? null
          : MajorSubject.fromJson(json['major_obj']);
    }
    majorText = json['major_text'];
    enrolledDate = json['enrolled_date'] == null
        ? null
        : DateTime.parse(json['enrolled_date']);
    graduationDate = json['graduation_date'] == null
        ? null
        : DateTime.parse(json['graduation_date']);
    if (json['institution_obj'] != null) {
      institutionObj = json['institution_obj']['id'] != null
          ? new Institution.fromJson(json['institution_obj'])
          : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['degree_text'] = this.degree;
    data['is_ongoing'] = this.isOnGoing;
    data['institution_id'] = this.institutionId;
    data['education_level_id'] = this.educationLevel;
    data['description'] = this.description;
    data['institution_text'] = this.institutionText;
    data['cgpa'] = this.cgpa;
    data['is_ongoing'] = this.isOnGoing??false;
    data['major_id'] = this.major?.id;
    data['major_text'] = this.majorText;
    data['enrolled_date'] = this.enrolledDate.toYYYMMDDString;
    data['graduation_date'] = this.graduationDate.toYYYMMDDString;
    return data;
  }
}
