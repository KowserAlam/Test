import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_list_model.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_model.dart';
import 'package:jobxprss_company/features/manage_jobs/models/job_status.dart';
export 'package:jobxprss_company/features/manage_jobs/models/job_status.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_service.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:logger/logger.dart';

class ManageJobRepository {
  Future<Either<AppError, ManageJobListScreenDataModel>> getJobList(
      {JobStatus jobStatus,int page = 1,pageSize=15}) async {

    var url = "${Urls.openJobsCompany}?page=$page&status=${jobStatus??""}&page_size=$pageSize";

    logger.i(url);

    try {
      var response = await ApiClient().getRequest(url);
//      debugPrint(url);
      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        var decodedJson = json.decode(utf8.decode(response.bodyBytes));
//        Logger().i(decodedJson);
        var jobList = fromJson(decodedJson);
        var dataModel = ManageJobListScreenDataModel(
            jobList: jobList,
            count: decodedJson['count'],
            nextPage: decodedJson['pages'] != null
                ? decodedJson['pages']['next_url'] != null
                : false);
        return Right(dataModel);
      } else if (response.statusCode == 401) {
        BotToast.showText(text: StringResources.unauthorizedText);
        return Left(AppError.unauthorized);
      } else {
        BotToast.showText(text: StringResources.somethingIsWrong);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      logger.e(e);
      BotToast.showText(text: StringResources.couldNotReachServer);
      return Left(AppError.networkError);
    } catch (e) {
      logger.e(e);
      BotToast.showText(text: StringResources.somethingIsWrong);
      return Left(AppError.serverError);
    }
  }

  List<JobListModel> fromJson(Map<String, dynamic> json) {
    List<JobListModel> jobList = new List<JobListModel>();
    if (json['results'] != null) {
      json['results'].forEach((v) {
        jobList.add(new JobListModel.fromJson(v));
      });
    }
    return jobList;
  }

  Future<Either<AppError, JobModel>> fetchJobDetails(String slug) async {
    //var url = "/api/load_job/seo-expert-78caf3ac";
    var url = "${Urls.jobDetailsUrl}$slug/";

    try {
      var response = await ApiClient().getRequest(url);
      debugPrint(url);
      logger.i(response.statusCode);
     // logger.i(response.body);
      if (response.statusCode == 200) {
        var mapData = json.decode(utf8.decode(response.bodyBytes));

        var jobDetails = JobModel.fromJson(mapData);
        return Right(jobDetails);
      } else {
        BotToast.showText(text: StringResources.somethingIsWrong);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      logger.e(e);
      BotToast.showText(text: StringResources.couldNotReachServer);
      return Left(AppError.networkError);
    } catch (e) {
      logger.e(e);
      BotToast.showText(text: StringResources.somethingIsWrong);
      return Left(AppError.serverError);
    }
  }
  
}

class ManageJobListScreenDataModel {
  int count;
  bool nextPage;
  List<JobListModel> jobList;

  ManageJobListScreenDataModel({
    @required this.count,
    @required this.nextPage,
    @required this.jobList,
  });
}
