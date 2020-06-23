

import 'package:jobxprss_company/features/company_profile/models/company.dart';

class CompanyScreenDataModel {
  int count;
  bool next;
  bool previous;
  List<Company> companies;

  CompanyScreenDataModel({this.count, this.next, this.previous, this.companies});

  CompanyScreenDataModel.fromJson(Map<String, dynamic> json) {
    count = json['count']??0;
    next = json['next'] != null;
    previous = json['previous'] != null;
    if (json['results'] != null) {
      companies = new List<Company>();
      json['results'].forEach((v) {
        companies.add(new Company.fromJson(v));
      });
    }
  }
}
