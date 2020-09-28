import 'package:jobxprss_company/method_extension.dart';

import 'organization.dart';

class MembershipInfo {
  int membershipId;
  String orgName;
  String positionHeld;
  bool membershipOngoing;
  DateTime startDate;
  DateTime endDate;
  String description;
  Organization organization;

  MembershipInfo(
      {this.membershipId,
        this.orgName,
        this.positionHeld,
        this.membershipOngoing,
        this.startDate,
        this.endDate,
        this.description,
        this.organization});

  MembershipInfo.fromJson(Map<String, dynamic> json) {
    membershipId = json['id'];
    orgName = json['organization']?.toString();
    positionHeld = json['position_held']?.toString();
    membershipOngoing = json['membership_ongoing'];
    if (json['organization_obj'] != null) {
      organization = json['organization_obj']['id'] != null
          ? new Organization.fromJson(json['organization_obj'])
          : null;
    }
    if (json['start_date'] != null) {
      startDate = DateTime.parse(json['start_date']);
    }
    if (json['end_date'] != null) {
      endDate = DateTime.parse(json['end_date']);
    }
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.membershipId;
    data['organization'] = this.orgName;
    data['position_held'] = this.positionHeld;
    data['membership_ongoing'] = this.membershipOngoing;
    data['start_date'] = this.startDate.toYYYMMDDString;
    data['end_date'] = this.endDate.toYYYMMDDString;
    data['description'] = this.description;
    return data;
  }
}