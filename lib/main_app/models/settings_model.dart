class SettingsModel {
  String id;
  String facebookUrl;
  String linkedinUrl;
  String twitterUrl;
  String appstoreUrl;
  String playstoreUrl;
  String logoUrl;
  String adminEmail;
  String supportEmail;
  String address;
  String phone;
  int zoom;
  String latitude;
  String longitude;

  SettingsModel(
      {this.id,
      this.facebookUrl,
      this.linkedinUrl,
      this.twitterUrl,
      this.appstoreUrl,
      this.playstoreUrl,
      this.logoUrl,
      this.adminEmail,
      this.supportEmail,
      this.address,
      this.phone,
      this.zoom,
      this.latitude,
      this.longitude});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    facebookUrl = json['facebook_url'];
    linkedinUrl = json['linkedin_url'];
    twitterUrl = json['twitter_url'];
    appstoreUrl = json['appstore_url'];
    playstoreUrl = json['playstore_url'];
    logoUrl = json['logo_url'];
    adminEmail = json['admin_email'];
    supportEmail = json['support_email'];
    address = json['address'];
    phone = json['phone']?.toString();
    zoom = json['zoom'];

    if (json['longitude'] != null) {
      latitude = json['latitude'];
    }
    if (json['longitude'] != null) {
      longitude = json['longitude'];
    }
  }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['facebook_url'] = this.facebookUrl;
//    data['linkedin_url'] = this.linkedinUrl;
//    data['twitter_url'] = this.twitterUrl;
//    data['appstore_url'] = this.appstoreUrl;
//    data['playstore_url'] = this.playstoreUrl;
//    data['logo_url'] = this.logoUrl;
//    data['admin_email'] = this.adminEmail;
//    data['support_email'] = this.supportEmail;
//    data['address'] = this.address;
//    data['phone'] = this.phone;
//    data['zoom'] = this.zoom;
//    data['latitude'] = this.latitude;
//    data['longitude'] = this.longitude;
//    return data;
//  }
}
