import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jobxprss_company/features/dashboard/models/info_box_data_model.dart';
import 'package:jobxprss_company/features/dashboard/models/skill_job_chart_data_model.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/util/logger_util.dart';

class DashBoardRepository {
  Future<Either<AppError, InfoBoxDataModel>> getInfoBoxData() async {
    try {
      var res = await ApiClient().getRequest(Urls.infoBoxUrl);
      logger.i(res.statusCode);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        logger.i(decodedJson);
        var model = InfoBoxDataModel.fromJson(decodedJson);
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

  Future<Either<AppError, List<SkillJobChartDataModel>>>
      getSkillJobChart() async {
    try {
      var res = await ApiClient().getRequest(Urls.dashboardChartUrl);
      logger.i(res.statusCode);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        List<SkillJobChartDataModel> data = [];
        decodedJson.forEach((e) {
          data.add(SkillJobChartDataModel.fromJson(e));
        });
        data.sort((a, b) => b.dateTimeValue.compareTo(a.dateTimeValue));
        return Right(data);
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

//  Future<double> getProfileCompletenessPercent() async {
//    try {
//      var res = await ApiClient().getRequest(Urls.profileCompleteness);
//      if (res.statusCode == 200) {
//        var data = json.decode(res.body);
//        return data['percent_of_profile_completeness']?.toDouble();
//      } else {
//        return 0;
//      }
//    } catch (e) {
//      logger.e(e);
//      return 0;
//    }
//  }
}
