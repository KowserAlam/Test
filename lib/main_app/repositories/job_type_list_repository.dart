import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';

class JobTypeListRepository {
  Future<Either<AppError, List<JobType>>> getList() async {
    try {
      var cache = await Cache.load(Urls.jobTypeListUrl);
      if (cache != null) {
        var decodedJson = json.decode(cache);
        List<JobType> list = fromJson(decodedJson);
//        logger.i(decodedJson);
        return Right(list);
      }
      var res = await ApiClient().getRequest(Urls.jobTypeListUrl);
      logger.i(res.statusCode);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
//        logger.i(decodedJson);

        Cache.remember(Urls.jobTypeListUrl, res.body, 604800);
        List<JobType> list = fromJson(decodedJson);
        logger.i(decodedJson);
        return Right(list);
      } else {
        return Left(AppError.unknownError);
      }
    } catch (e) {
      logger.e(e);

      return Left(AppError.serverError);
    }
  }

  List<JobType> fromJson(json) {
    List<JobType> list = [];
//   List<Map<String,dynamic>> tl = json.cast<Map<String,dynamic>>();
//    tl.map<String>((e) => e['name']).toList();
    json.forEach((element) {
      list.add(JobType.fromJson(element));
    });
    return list;
  }

  Future<JobType> getIdToObj(String jobSiteId) {
    return getList().then((value) => value.fold((l) => null,
        (r) => r.firstWhere((element) => element.id == jobSiteId))).catchError((err){logger.i(err);});
  }
}

class JobType extends Equatable {
  final String id;
  final String text;

  JobType({this.id, this.text});

  factory JobType.fromJson(Map<String, dynamic> json) {
    return JobType(id: json['id'], text: json['text']);
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
    return 'JobType{id: $id, text: $text}';
  }
}
