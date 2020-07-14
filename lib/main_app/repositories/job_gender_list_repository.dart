import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';

class JobGenderListRepository {
  Future<Either<AppError, List<String>>> getList() async {
    try {

      var cache = await Cache.load(Urls.jobGenderList);
      if (cache != null) {
        var decodedJson = json.decode(cache);
        List<String> list = fromJson(decodedJson);
//        print(decodedJson);
        return Right(list);
      }
      var res = await ApiClient().getRequest(Urls.jobGenderList);
      print(res.statusCode);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        print(decodedJson);

        Cache.remember(Urls.jobGenderList, res.body,60*60);
        List<String> list = fromJson(decodedJson);
        return Right(list);
      } else {
        return Left(AppError.unknownError);
      }
    } catch (e) {
      print(e);

      return Left(AppError.serverError);
    }
  }

  List<String> fromJson(json) {
    List<String> list = [];
//   List<Map<String,dynamic>> tl = json.cast<Map<String,dynamic>>();
//    tl.map<String>((e) => e['name']).toList();
    json.forEach((element) {
      list.add(element['name']);
    });
    return list;
  }
}
