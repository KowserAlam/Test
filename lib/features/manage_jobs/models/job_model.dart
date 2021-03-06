import 'package:dartz/dartz_unsafe.dart';
import 'package:jobxprss_company/features/company_profile/models/company.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:jobxprss_company/main_app/models/skill.dart';
import 'package:jobxprss_company/method_extension.dart';

import 'job_status.dart';

class JobModel {
  String jobId;
  String slug;
  String title;
  String jobCity;
  String jobAddress;
  String jobCountry;
  String jobArea;
  int salaryMin;
  int salaryMax;
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
  List<Skill> jobSkills;
  bool isApplied;
  bool isFavourite;
  SalaryOption salaryOption;
  DateTime publishDate;
  DateTime postDate;
  String jobCategory;
  String jobSite;
  String jobNature;
  String jobType;
  String additionalRequirements;
  String companyProfile;
  JobStatus jobStatus;

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
      this.salaryOption,
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
      this.companyProfile,
      this.jobStatus,});

  JobModel.fromJson(Map<String, dynamic> json) {
    String baseUrl = FlavorConfig?.instance?.values?.baseUrl;

    jobId = json['job_id']?.toString();
    slug = json['slug'];
    title = json['title']?.toString();
    jobCity = json['job_city']?.toString()?.swapValueByComa;
    if (json['salary_min'] != null) {
      salaryMin = num.parse(json['salary_min']?.toString()).toInt();
    }

    if (json['salary_max'] != null) {
      salaryMax = num.parse(json['salary_max']?.toString()).toInt();
    }

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
        jobSkills.add(Skill.fromJson(element));
      });
    }

    salaryOption = _salaryOptionToEnum(json['salary_option']);
    isApplied = json['is_applied'] == null
        ? false
        : (json['is_applied'] == "True" ? true : false);
    isFavourite = json['is_favourite'] == null
        ? false
        : (json['is_favourite'] == "True" ? true : false);

    jobStatus = _parseJobStatusEnum(json['status']);

//    if (json['profile_picture'] != null) {
//      profilePicture = "$baseUrl${json['profile_picture']}";
//    }
  }

  SalaryOption _salaryOptionToEnum(String option) {
    switch (option) {
      case "RANGE":
        {
          return SalaryOption.RANGE;
        }
      case "AMOUNT":
        {
          return SalaryOption.AMOUNT;
        }
      default:
        {
          return SalaryOption.NEGOTIABLE;
        }
    }
  }
}

enum SalaryOption { NEGOTIABLE, RANGE, AMOUNT }

extension SalaryOptionEX on SalaryOption {
  String get salaryOptionToString {
    switch (this) {
      case SalaryOption.NEGOTIABLE:
        return "NEGOTIABLE";
        break;
      case SalaryOption.RANGE:
        return "RANGE";
        break;
      case SalaryOption.AMOUNT:
        return "AMOUNT";
        break;
      default:
        return "NEGOTIABLE";
    }
  }
}

JobStatus _parseJobStatusEnum(String status) {
  switch (status) {
    case "DRAFT":
      return JobStatus.DRAFT;
    case "POSTED":
      return JobStatus.POSTED;
    case "PUBLISHED":
      return JobStatus.PUBLISHED;
    case "UNPUBLISHED":
      return JobStatus.UNPUBLISHED;
    default:
      return JobStatus.DRAFT;
  }
}