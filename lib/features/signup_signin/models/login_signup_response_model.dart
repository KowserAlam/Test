
import 'package:jobxprss_company/main_app/resource/json_keys.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';

class LoginSignUpResponseModel {
  String status;
  int code;
  String message;
  Result result;

  LoginSignUpResponseModel({this.status, this.code, this.message, this.result});

  LoginSignUpResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }

  LoginSignUpResponseModel errorDefault(){
    return LoginSignUpResponseModel(
      status: JsonKeys.failed,
      code: 401,
      message: StringResources.somethingIsWrong,
      result: Result(
        user: ResponseUser(email: "none")
      )
    );
  }

  LoginSignUpResponseModel errorNoInternet(){
    return LoginSignUpResponseModel(
        status: JsonKeys.failed,
        code: 402,
        message: StringResources.couldNotReachServer,
        result: Result(
            user: ResponseUser(email: "none")
        )
    );
  }



}

class Result {
  ResponseUser user;

  Result({this.user});

  Result.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new ResponseUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class ResponseUser {
  String email;
  String userId;


  ResponseUser({this.email,this.userId});

  ResponseUser.fromJson(Map<String, dynamic> json) {
    email = json['examinee_email'];
    userId = json['examinee_id'] != null ? json['examinee_id'].toString():"" ;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examinee_email'] = this.email;
    data['examinee_id'] = this.userId;
    return data;
  }
}