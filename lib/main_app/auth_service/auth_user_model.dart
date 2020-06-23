
class AuthUserModel {
  String refresh;
  String accessToken;
  String email;
  String userId;
  String name;
  String cId;

  AuthUserModel(
      {this.refresh,
      this.accessToken,
      this.email,
      this.userId,
      this.name,
      this.cId,});

  AuthUserModel.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    accessToken = json['access'];
    if (json["user"] != null) {
      email = json["user"]['email'];
      userId = json['user']['id']?.toString();
    }
    if (json['company'] != null) {
      name = json['company']['name'];
      cId = json['company']['name'];
    }
  }
  AuthUserModel.fromJsonLocal(Map<String, dynamic> json) {
    refresh = json['refresh']?.toString();
    accessToken = json['access']?.toString();
    userId = json['user_id']?.toString();
      email = json["email"]?.toString();
      name = json['name']?.toString();
      cId = json['c_id']?.toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.accessToken;
    data['email'] = this.email;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['c_id'] = this.cId;
    return data;
  }

  @override
  String toString() {
    return 'AuthUserModel{refresh: $refresh, accessToken: $accessToken, email: $email, userId: $userId, fullName: $name, professionalId: $cId}';
  }
}
