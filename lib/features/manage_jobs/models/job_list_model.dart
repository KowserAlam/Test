

import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';

class JobListModel {
  String jobId;
  String slug;
  String title;
  String jobCity;
  String employmentStatus;
  String companyName;
  String profilePicture;
  String jobNature;
  String jobSite;
  String jobType;
  int appliedCount;
  int favoriteCount;
  DateTime postDate;
  DateTime applicationDeadline;

  JobListModel({
    this.jobId,
    this.slug,
    this.title,
    this.jobCity,
    this.employmentStatus,
    this.companyName,
    this.profilePicture,
    this.jobNature,
    this.jobSite,
    this.jobType,
    this.postDate,
    this.applicationDeadline,
    this.appliedCount,
    this.favoriteCount,
  });

  JobListModel.fromJson(Map<String, dynamic> json) {
    String baseUrl = FlavorConfig?.instance?.values?.baseUrl;

    appliedCount = json['applied_count']??0;
    favoriteCount = json['favorite_count']??0;
    jobId = json['job_id'];
    slug = json['slug'];
    title = json['title'];
    jobCity = json['job_city'];
    employmentStatus = json['employment_status'];

    if(json['company'] != null){
      profilePicture = "$baseUrl${json['company']['profile_picture']}";
      companyName = json['company']['name'];
    }
    jobNature = json['job_nature'];
    jobSite = json['job_site'];
    jobType = json['job_type'];


    if (json['application_deadline'] != null) {
      applicationDeadline = DateTime.parse(json['application_deadline']);
    }

    if (json['post_date'] != null) {
      postDate = DateTime.parse(json['post_date']);
    }

  }
}
