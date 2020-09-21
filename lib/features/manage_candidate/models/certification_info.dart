import 'package:jobxprss_company/method_extension.dart';

class CertificationInfo {
  int certificationId;
  String certificationName;
  String organizationName;
  bool hasExpiryPeriod;
  DateTime issueDate;
  DateTime expiryDate;
  String credentialId;
  String credentialUrl;

  CertificationInfo(
      {this.certificationId,
        this.certificationName,
        this.organizationName,
        this.hasExpiryPeriod,
        this.issueDate,
        this.expiryDate,
        this.credentialId,
        this.credentialUrl});

  CertificationInfo.fromJson(Map<String, dynamic> json) {
    certificationId = json['id'];
    certificationName = json['certificate_name']?.toString();
    organizationName = json['organization']?.toString();
    hasExpiryPeriod = json['has_expiry_period'];
    credentialId = json['credential_id'];
    credentialUrl = json['credential_url'];
    if(json['issue_date'] != null){
      issueDate = DateTime.parse(json['issue_date']);
    };
    if(json['expiry_date'] != null){
      expiryDate = DateTime.parse(json['expiry_date']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.certificationId;
    data['certificate_name'] = this.certificationName;
    data['organization'] = this.organizationName;
    data['has_expiry_period'] = this.hasExpiryPeriod;
    data['issue_date'] = this.issueDate.toYYYMMDDString;
    data['expiry_date'] = this.expiryDate.toYYYMMDDString;
    data['credential_id'] = this.credentialId;
    data['credential_url'] = this.credentialUrl;
    return data;
  }
}
