class InfoBoxDataModel {
  int favouriteJobCount;
  int appliedJobCount;
  int skillsCount;

  InfoBoxDataModel(
      {this.favouriteJobCount, this.appliedJobCount, this.skillsCount});

  InfoBoxDataModel.fromJson(Map<String, dynamic> json) {
    favouriteJobCount = json['favourite_job_count'];
    appliedJobCount = json['applied_job_count'];
    skillsCount = json['skills_count'];
  }

}