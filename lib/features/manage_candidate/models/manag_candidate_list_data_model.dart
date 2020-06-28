import 'package:jobxprss_company/main_app/models/candidate.dart';

class ManageCandidateListDataModel {
  int count;
  Pages pages;
  List<Candidate> candidates;

  ManageCandidateListDataModel({
    this.count,
    this.pages,
    this.candidates,
  });

  ManageCandidateListDataModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pages = json['pages'] != null ? new Pages.fromJson(json['pages']) : null;
    if (json['results'] != null) {
      candidates = new List<Candidate>();
      json['results'].forEach((v) {
        candidates.add(new Candidate.fromJson(v));
      });
    }
  }
}

class Pages {
  String previousUrl;
  String nextUrl;
  Pages({this.previousUrl, this.nextUrl});
  Pages.fromJson(Map<String, dynamic> json) {
    previousUrl = json['previous_url'];
    nextUrl = json['next_url'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['previous_url'] = this.previousUrl;
    data['next_url'] = this.nextUrl;
    return data;
  }
}
