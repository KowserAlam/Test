import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:logger/logger.dart';
class CountryRepository {
  Future<String> getCountryNameFromCode(String code) async {
    try {
      var list = await getList();
      return list.firstWhere((element) => element.code == code).name;
    } catch (e) {
      logger.e(e);
      return code;
    }
  }
  Future<Country> getCountryObjFromCode(String code) async {
    try {
      var list = await getList();
      return list.firstWhere((element) => element.code == code);
    } catch (e) {
      logger.e(e);
      return Country(code: code,name: code);
    }
  }

  Future<List<Country>> getList() async {
    try {
      List<Country> _list = [];
      Map<String, dynamic> decodedJson =
      await Cache.load(Urls.cityListUrl).then((value) async {
        if (value != null) {
          debugPrint("Country,city list from cache");
          return value;
        } else {
          var res = await ApiClient().getRequest(Urls.cityListUrl);
          logger.i(res.statusCode);

          var data = json.decode(res.body);
          Cache.remember(Urls.cityListUrl, data, 30 * 60);
          debugPrint("Country,city list from server");
          return data;
        }
      });
//      Logger().i(decodedJson);
      decodedJson.forEach((key, value) {
        _list.add(Country(code: key, name: value));
      });

      return _list;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }
  Future<List<String>> getCityCountryList() async {
    try {
      List<String> _list = [];
      var decodedJson = await Cache.load(Urls.cityListUrl).then((value) async {
        if (value != null) {
          debugPrint("Country,city list from cache");
          var data = json.decode(value);
          return data;
        } else {
          var res = await ApiClient().getRequest(Urls.cityListUrl);
          logger.i(res.statusCode);
          Cache.remember(Urls.cityListUrl, res.body, 30 * 60);
          var data = json.decode(res.body);
          debugPrint("Country,city list from server");
          return data;
        }
      });
//      Logger().i(decodedJson);
      decodedJson.forEach(( value) {
        _list.add(value["name"]);
      });

      return _list;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }
}

class Country extends Equatable {
  String name;
  String code;

  Country({this.name, this.code});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json["name"],
    );
  }

  @override
  String toString() {
    return name;
  }

  @override
  // TODO: implement props
  List<Object> get props => [name, code];
}
