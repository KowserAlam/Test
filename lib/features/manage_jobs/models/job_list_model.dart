import 'package:jobxprss_company/features/manage_jobs/models/job_status.dart';
export 'package:jobxprss_company/features/manage_jobs/models/job_status.dart';
import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';

class JobListModel {
  String jobId;
  String slug;
  String title;
  String jobCity;
  String employmentStatus;
  String jobNature;
  String jobSite;
  String jobType;
  int appliedCount;
  int favoriteCount;
  DateTime postDate;
  DateTime applicationDeadline;
  JobStatus jobStatus;

  JobListModel({
    this.jobId,
    this.slug,
    this.title,
    this.jobCity,
    this.employmentStatus,
    this.jobNature,
    this.jobSite,
    this.jobType,
    this.postDate,
    this.applicationDeadline,
    this.appliedCount,
    this.favoriteCount,
    this.jobStatus,
  });

  JobListModel.fromJson(Map<String, dynamic> json) {
    String baseUrl = FlavorConfig?.instance?.values?.baseUrl;

    appliedCount = json['applied_count'] ?? 0;
    favoriteCount = json['favorite_count'] ?? 0;
    jobId = json['job_id'];
    slug = json['slug'];
    title = json['title'];
    jobCity = json['job_city'];
    employmentStatus = json['employment_status'];
    jobNature = json['job_nature'];
    jobSite = json['job_site'];
    jobType = json['job_type'];
    jobStatus = _parseJobStatusEnum(json['status']);

    if (json['application_deadline'] != null) {
      applicationDeadline = DateTime.parse(json['application_deadline']);
    }

    if (json['post_date'] != null) {
      postDate = DateTime.parse(json['post_date']);
    }
  }

  JobStatus _parseJobStatusEnum(String status) {
    switch (status) {
      case "RAW":
        return JobStatus.RAW;
      case "DRAFT":
        return JobStatus.DRAFT;
      case "APPROVED":
        return JobStatus.APPROVED;
      case "REVIEWED":
        return JobStatus.REVIEWED;
      case "PUBLISHED":
        return JobStatus.PUBLISHED;
      case "UNPUBLISHED":
        return JobStatus.UNPUBLISHED;
      default:
        return JobStatus.NOT_READY;
    }
  }
}



