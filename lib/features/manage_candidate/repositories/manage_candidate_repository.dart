import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:jobxprss_company/features/manage_candidate/models/candidate_model.dart';
import 'package:jobxprss_company/features/manage_candidate/models/manag_candidate_list_data_model.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_service.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';
import 'package:logger/logger.dart';

class ManageCandidateRepository{

  Future<Either<AppError, CandidateModel>> getCandidateProfile(String slug) async {
    try {

      var url = "${Urls.applicantProfileUrl}/$slug/";
      logger.i(url);
      var response = await ApiClient().getRequest(url);
//      logger.i(response.statusCode);
     logger.i(response.body);

      if (response.statusCode == 200) {
        var mapJson = json.decode(response.body);
//      var mapJson = json.decode(dummyData);
//        Logger().i(mapJson);
        var userModel = CandidateModel.fromJson(mapJson);
        return Right(userModel);
      } else {
        return left(AppError.httpError);
      }
    } on SocketException catch (e) {
      logger.e(e);
      BotToast.showText(text: StringResources.unableToReachServerMessage);
      return left(AppError.networkError);
    } catch (e) {
      logger.e(e);
      BotToast.showText(text: StringResources.somethingIsWrong);
      return left(AppError.serverError);
    }
  }
  Future<Either<AppError, ManageCandidateListDataModel>> getCandidateList(String jobId) async {
    try {
      var url = "${Urls.manageCandidateList}/$jobId/";
      var res = await ApiClient().getRequest(url);
      logger.i(res.statusCode);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        Logger().i(decodedJson);
   print(res.body);
        var model = ManageCandidateListDataModel.fromJson(decodedJson);
        return Right(model);
      } else if (res.statusCode == 401) {
        return Left(AppError.unauthorized);
      } else {
        return Left(AppError.serverError);
      }
    } on SocketException catch (e) {
      logger.e(e);
      return Left(AppError.networkError);
    } catch (e) {
      logger.e(e);
      return Left(AppError.unknownError);
    }
  }
}

