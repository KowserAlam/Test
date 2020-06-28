class InfoBoxDataModel {
  int numberOfJobs;
  int applicationCount;
  int shortListed;

  InfoBoxDataModel(
      {this.numberOfJobs, this.applicationCount, this.shortListed});

  InfoBoxDataModel.fromJson(Map<String, dynamic> json) {
    numberOfJobs = json['company_number_of_job'];
    applicationCount = json['company_appilcation_count'];
    shortListed = json['company_application_shortlist_count'];
  }

}