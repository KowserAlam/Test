import 'package:jobxprss_company/main_app/flavour/flavour_config.dart';
import 'package:jobxprss_company/main_app/resource/json_keys.dart';

class AuthUserModel {
  String refresh;
  String accessToken;
  String email;
  String userId;
  String fullName;
  String professionalId;

  AuthUserModel(
      {this.refresh,
      this.accessToken,
      this.email,
      this.userId,
      this.fullName,
      this.professionalId,});

  AuthUserModel.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    accessToken = json['access'];
    if (json["user"] != null) {
      email = json["user"]['email'];
      userId = json['user']['id']?.toString();
    }
    if (json['pro'] != null) {
      fullName = json['pro']['full_name'];
      professionalId = json['pro']['id'];


    }
  }
  AuthUserModel.fromJsonLocal(Map<String, dynamic> json) {
    refresh = json['refresh']?.toString();
    accessToken = json['access']?.toString();
    userId = json['user_id']?.toString();
      email = json["email"]?.toString();
      fullName = json['full_name']?.toString();
      professionalId = json['professional_id']?.toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.accessToken;
    data['email'] = this.email;
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['professional_id'] = this.professionalId;
    return data;
  }

  @override
  String toString() {
    return 'AuthUserModel{refresh: $refresh, accessToken: $accessToken, email: $email, userId: $userId, fullName: $fullName, professionalId: $professionalId}';
  }
}
