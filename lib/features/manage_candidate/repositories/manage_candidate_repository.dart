import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jobxprss_company/features/manage_candidate/models/manag_candidate_list_data_model.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';

class ManageCandidateRepository{

  Future<Either<AppError, ManageCandidateListDataModel>> getCandidateList(String jobId) async {
    try {
      var url = "${Urls.manageCandidateList}/$jobId/";
      var res = await ApiClient().getRequest(url);
      print(res.statusCode);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        var model = ManageCandidateListDataModel.fromJson(decodedJson);
        return Right(model);
      } else if (res.statusCode == 401) {
        return Left(AppError.unauthorized);
      } else {
        return Left(AppError.serverError);
      }
    } on SocketException catch (e) {
      print(e);
      return Left(AppError.networkError);
    } catch (e) {
      print(e);
      return Left(AppError.unknownError);
    }
  }
}

