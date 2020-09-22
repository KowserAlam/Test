import 'package:jobxprss_company/features/manage_candidate//models/nationality.dart';
import 'package:jobxprss_company/features/manage_candidate/models/religion.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:jobxprss_company/main_app/resource/const.dart';

class UserPersonalInfo {
  String id;
  String professionalId;
  String fullName;
  String email;
  String phone;
  String address;
  String aboutMe;
  String profileImage;
  String password;
  String fatherName;
  String motherName;
  String facebookId;
  String twitterId;
  String linkedinId;
  DateTime dateOfBirth;
  String expectedSalaryMin;
  String expectedSalaryMax;
  String industryExpertise;
  int user;
  String gender;
  String status;
  String experience;
  String qualification;
  String nationality;
  String religion;
  String permanentAddress;
  String currentLocation;
  String currentCompany;
  String currentDesignation;
  Religion religionObj;
  Nationality nationalityObj;
  String bloodGroup;
  String slug;

  UserPersonalInfo({
    this.id,
    this.professionalId,
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.aboutMe,
    this.profileImage,
    this.password,
    this.fatherName,
    this.motherName,
    this.facebookId,
    this.twitterId,
    this.linkedinId,
    this.dateOfBirth,
    this.expectedSalaryMin,
    this.expectedSalaryMax,
    this.industryExpertise,
    this.user,
    this.gender,
    this.status,
    this.experience,
    this.qualification,
    this.nationality,
    this.religion,
    this.permanentAddress,
    this.currentLocation,
    this.religionObj,
    this.currentCompany,
    this.currentDesignation,
    this.bloodGroup,
  });

  UserPersonalInfo.fromJson(Map<String, dynamic> json) {
    String baseUrl = FlavorConfig?.instance?.values?.baseUrl;
    var imageUlr = json['image'] == null ? kDefaultUserImageNetwork : "$baseUrl${json['image']}";

    id = json['id'];
    slug = json['slug'];
    professionalId = json['professional_id'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    aboutMe = json['about_me'];
    profileImage = imageUlr;
    password = json['password'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    facebookId = json['facebook_id'];
    twitterId = json['twitter_id'];
    linkedinId = json['linkedin_id'];
    currentLocation = json['current_location'];
    currentCompany = json['current_company'];
    currentDesignation = json['current_designation'];
    bloodGroup = json['blood_group'];


    if (json['date_of_birth'] != null) {
      dateOfBirth = DateTime.parse(json['date_of_birth']);
    }

    if (json['religion_obj'] != null) {
      religionObj = json['religion_obj']['id'] == null? null:Religion.fromJson(json['religion_obj']);
    }
    if (json['nationality_obj'] != null) {
      nationalityObj = json['nationality_obj']['id'] == null? null:Nationality.fromJson(json['nationality_obj']);
    }

    expectedSalaryMin = json['expected_salary_min'];
    expectedSalaryMax = json['expected_salary_max'];
    industryExpertise = json['industry_expertise'];
    user = json['user'];
    gender = json['gender'];
    status = json['status'];
    experience = json['experience'];
    qualification = json['qualification'];
    nationality = json['nationality']?.toString();
    religion = json['religion']?.toString();
    permanentAddress = json['permanent_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['about_me'] = this.aboutMe;
    data['image'] = this.profileImage;
    data['password'] = this.password;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['facebbok_id'] = this.facebookId;
    data['twitter_id'] = this.twitterId;
    data['linkedin_id'] = this.linkedinId;
    data['date_of_birth'] = this.dateOfBirth.toIso8601String();
    data['expected_salary_min'] = this.expectedSalaryMin;
    data['expected_salary_max'] = this.expectedSalaryMax;
    data['industry_expertise'] = this.industryExpertise;
    data['gender'] = this.gender;
    data['status'] = this.status;
    data['experience'] = this.experience;
    data['qualification'] = this.qualification;
    data['nationality'] = this.nationality;
    data['religion'] = this.religion;
    data['permanent_address'] = this.permanentAddress;
    data['current_location'] = this.currentLocation;
    return data;
  }
}
