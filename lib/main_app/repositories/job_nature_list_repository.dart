import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';

class JobNatureListRepository {
  Future<Either<AppError, List<JobNature>>> getList() async {
    try {
      var cache = await Cache.load(Urls.jobNatureList);
      if (cache != null) {
        var decodedJson = json.decode(cache);
        List<JobNature> list = fromJson(decodedJson);
//        logger.i(decodedJson);
        return Right(list);
      }
      var res = await ApiClient().getRequest(Urls.jobNatureList);
      logger.i(res.statusCode);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
//        logger.i(decodedJson);

        Cache.remember(Urls.jobNatureList, res.body, 604800);
        List<JobNature> list = fromJson(decodedJson);
        // logger.i(decodedJson);
        return Right(list);
      } else {
        return Left(AppError.unknownError);
      }
    } catch (e) {
      logger.e(e);

      return Left(AppError.serverError);
    }
  }

  List<JobNature> fromJson(json) {
    List<JobNature> list = [];
//   List<Map<String,dynamic>> tl = json.cast<Map<String,dynamic>>();
//    tl.map<String>((e) => e['name']).toList();
    json.forEach((element) {
      list.add(JobNature.fromJson(element));
    });
    return list;
  }

  Future<JobNature> getIdToObj(String jobSiteId) {
    return getList().then((value) => value.fold((l) => null,
        (r) => r.firstWhere((element) => element.id == jobSiteId))).catchError((err){logger.i(err);});
  }
}

class JobNature extends Equatable {
  final String id;
  final String text;

  JobNature({this.id, this.text});

  factory JobNature.fromJson(Map<String, dynamic> json) {
    return JobNature(id: json['id'], text: json['text']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [id, text];

  @override
  String toString() {
    return 'JobNature{id: $id, text: $text}';
  }
}
