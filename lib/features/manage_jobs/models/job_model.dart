import 'package:dartz/dartz_unsafe.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';

class JobModel {
  String jobId;
  String slug;
  String title;
  String jobCity;
  String jobAddress;
  String jobCountry;
  String jobArea;
  String salaryMin;
  String salaryMax;
  String vacancy;
  DateTime applicationDeadline;
  String descriptions;
  String responsibilities;
  String education;
  String salary;
  String otherBenefits;
  String rawContent;
  bool termsAndCondition;
  DateTime createdAt;
  String industry;
  String employmentStatus;
  String experience;
  String qualification;
  String gender;
  String currency;
  String companyName;
  Company company;
  String division;
  String district;
  List<String> jobSkills;
  bool isApplied;
  bool isFavourite;

//  String profilePicture;
  DateTime publishDate;
  DateTime postDate;
  String jobCategory;
  String jobSite;
  String jobNature;
  String jobType;
  String additionalRequirements;
  String companyProfile;

  JobModel(
      {this.jobId,
      this.slug,
      this.title,
      this.jobCity,
      this.publishDate,
      this.salaryMin,
      this.salaryMax,
      this.vacancy,
      this.applicationDeadline,
      this.descriptions,
      this.responsibilities,
      this.education,
      this.isApplied,
      this.salary,
      this.otherBenefits,
      this.rawContent,
      this.termsAndCondition,
      this.createdAt,
      this.industry,
      this.employmentStatus,
      this.experience,
      this.qualification,
      this.gender,
      this.currency,
      this.companyName,
      this.company,
      this.division,
      this.district,
      this.jobSkills,
      this.isFavourite,
//      this.profilePicture,
      this.postDate,
      this.jobAddress,
      this.jobCountry,
      this.jobArea,
      this.jobCategory,
      this.jobNature,
      this.jobSite,
      this.jobType,
      this.additionalRequirements,
      this.companyProfile});

  JobModel.fromJson(Map<String, dynamic> json) {
    String baseUrl = FlavorConfig?.instance?.values?.baseUrl;

    jobId = json['job_id']?.toString();
    slug = json['slug'];
    title = json['title']?.toString();
    jobCity = json['job_city']?.toString();
    salaryMin = json['salary_min']?.toString();
    salaryMax = json['salary_max']?.toString();
    vacancy = json['vacancy']?.toString();
    if (json['application_deadline'] != null) {
      applicationDeadline = DateTime.parse(json['application_deadline']);
    }
    if (json['created_at'] != null) {
      createdAt = DateTime.parse(json['created_at']);
    }
    if (json['publish_date'] != null) {
      publishDate = DateTime.parse(json['publish_date']);
    }

    if (json['post_date'] != null) {
      postDate = DateTime.parse(json['post_date']);
    }

    descriptions = json['description']?.toString();
    responsibilities = json['responsibilities']?.toString();
    education = json['education']?.toString();
    salary = json['salary']?.toString();
    otherBenefits = json['other_benefits'];
    rawContent = json['raw_content'];
    termsAndCondition = json['terms_and_condition'];
    industry = json['industry']?.toString();
    employmentStatus = json['employment_status']?.toString();
    experience = json['experience']?.toString();
    qualification = json['qualification']?.toString();
    gender = json['job_gender']?.toString();
    currency = json['currency']?.toString();
    companyName = json['company_name']?.toString();

    if (json['company'] != null) {
      company = Company.fromJson(json['company']);
    }

    division = json['division'];
    district = json['district'];
    jobCategory = json['job_category'];
    jobAddress = json['address'];
    jobArea = json['job_area'];
    jobCity = json['job_city'];
    jobCountry = json['job_country'];
    jobSite = json['job_site'];
    jobNature = json['job_nature'];
    jobType = json['job_type'];
    companyProfile = json['company_profile'];
    additionalRequirements = json['additional_requirements'];

    if (json['job_skills'] != null) {
      jobSkills = [];
      json['job_skills'].forEach((element) {
        jobSkills.add(element['name']);
      });
    }

    isApplied = json['is_applied'] == null
        ? false
        : (json['is_applied'] == "True" ? true : false);
    isFavourite = json['is_favourite'] == null
        ? false
        : (json['is_favourite'] == "True" ? true : false);

//    if (json['profile_picture'] != null) {
//      profilePicture = "$baseUrl${json['profile_picture']}";
//    }
  }
}
