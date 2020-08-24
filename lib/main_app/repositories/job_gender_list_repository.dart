import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';

class JobGenderListRepository {
  Future<Either<AppError, List<String>>> getList() async {
    try {

      var cache = await Cache.load(Urls.jobGenderList);
      if (cache != null) {
        var decodedJson = json.decode(cache);
        List<String> list = fromJson(decodedJson);
//        logger.i(decodedJson);
        return Right(list);
      }
      var res = await ApiClient().getRequest(Urls.jobGenderList);
      logger.i(res.statusCode);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        logger.i(decodedJson);

        Cache.remember(Urls.jobGenderList, res.body,604800);
        List<String> list = fromJson(decodedJson);
        return Right(list);
      } else {
        return Left(AppError.unknownError);
      }
    } catch (e) {
      logger.e(e);

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
