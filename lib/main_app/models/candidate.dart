import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';

class Candidate {
  String id;
  String modifiedAt;
  String slug;
  String professionalId;
  String fullName;
  String email;
  String phone;
  String address;
  String aboutMe;
  String image;
  bool jobAlertStatus;
  String fatherName;
  String motherName;
  String facebookId;
  String twitterId;
  String linkedinId;
  String dateOfBirth;
  String bloodGroup;
  int expectedSalaryMin;
  int expectedSalaryMax;
  String permanentAddress;
  String currentLocation;
  String currentCompany;
  String currentDesignation;
  String industryExpertise;
  int user;
  String gender;
  String status;
  String experience;
  String qualification;
  int nationality;
  int religion;

  Candidate(
      {this.id,
      this.modifiedAt,
      this.slug,
      this.professionalId,
      this.fullName,
      this.email,
      this.phone,
      this.address,
      this.aboutMe,
      this.image,
      this.jobAlertStatus,
      this.fatherName,
      this.motherName,
      this.facebookId,
      this.twitterId,
      this.linkedinId,
      this.dateOfBirth,
      this.bloodGroup,
      this.expectedSalaryMin,
      this.expectedSalaryMax,
      this.permanentAddress,
      this.currentLocation,
      this.currentCompany,
      this.currentDesignation,
      this.industryExpertise,
      this.user,
      this.gender,
      this.status,
      this.experience,
      this.qualification,
      this.nationality,
      this.religion});

  Candidate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modifiedAt = json['modified_at'];
    slug = json['slug'];
    professionalId = json['professional_id'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    aboutMe = json['about_me'];
    if (json['image'] != null) {
      var baseUrl = FlavorConfig.instance?.values?.baseUrl;
      image = "$baseUrl${json['image']}";
    }

    jobAlertStatus = json['job_alert_status'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    facebookId = json['facebook_id'];
    twitterId = json['twitter_id'];
    linkedinId = json['linkedin_id'];
    dateOfBirth = json['date_of_birth'];
    bloodGroup = json['blood_group'];
    expectedSalaryMin = json['expected_salary_min'];
    expectedSalaryMax = json['expected_salary_max'];
    permanentAddress = json['permanent_address'];
    currentLocation = json['current_location'];
    currentCompany = json['current_company'];
    currentDesignation = json['current_designation'];
    industryExpertise = json['industry_expertise'];
    user = json['user'];
    gender = json['gender'];
    status = json['status'];
    experience = json['experience'];
    qualification = json['qualification'];
    nationality = json['nationality'];
    religion = json['religion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['modified_at'] = this.modifiedAt;
    data['slug'] = this.slug;
    data['professional_id'] = this.professionalId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['about_me'] = this.aboutMe;
    data['image'] = this.image;
    data['job_alert_status'] = this.jobAlertStatus;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['facebook_id'] = this.facebookId;
    data['twitter_id'] = this.twitterId;
    data['linkedin_id'] = this.linkedinId;
    data['date_of_birth'] = this.dateOfBirth;
    data['blood_group'] = this.bloodGroup;
    data['expected_salary_min'] = this.expectedSalaryMin;
    data['expected_salary_max'] = this.expectedSalaryMax;
    data['permanent_address'] = this.permanentAddress;
    data['current_location'] = this.currentLocation;
    data['current_company'] = this.currentCompany;
    data['current_designation'] = this.currentDesignation;
    data['industry_expertise'] = this.industryExpertise;
    data['user'] = this.user;
    data['gender'] = this.gender;
    data['status'] = this.status;
    data['experience'] = this.experience;
    data['qualification'] = this.qualification;
    data['nationality'] = this.nationality;
    data['religion'] = this.religion;
    return data;
  }
}
