import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';

class CountryRepository {
  Future<List<Country>> getList() async {
    try {
      List<Country> _list = [];
      var res = await ApiClient().getRequest(Urls.countryListUrl);
      var decodedJson = json.decode(res.body);
      print(res.statusCode);
      decodedJson.forEach((key, value) {
        _list.add(Country(code: key, name: value));
      });

      return _list;
    } catch (e) {
      print(e);
      return [];
    }
  }
}

class Country extends Equatable{
  String name;
  String code;

  Country({this.name, this.code});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json["name"],
      code: json["code"],
    );
  }

  @override
  String toString() {
    return name;
  }

  @override
  // TODO: implement props
  List<Object> get props => [name,code];
}
