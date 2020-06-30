
import 'dart:convert';

import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';

class CountryRepository{

  getList()async{
    try{
      var res = await ApiClient().getRequest(Urls.countryListUrl);
      var decodedJson = json.decode(res.body);
    }catch (e){
      return [];
      print(e);
    }



  }
}

class Country{
  String name;
  String code;

  Country({this.name, this.code});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json["name"],
      code: json["code"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "code": this.code,
    };
  }
}