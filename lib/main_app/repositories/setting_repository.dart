import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/models/settings_model.dart';

class SettingsRepository {
  Future<Either<AppError, SettingsModel>> getSettingInfo(
      {ApiClient apiClient}) async {
    var client = apiClient ?? ApiClient();

    try{
      var res = await client.getRequest(Urls.settingsUrl);
      print(res.statusCode);
      if (res.statusCode == 200) {
        var decodedJson = json.decode(res.body);
        var data = SettingsModel.fromJson(decodedJson[0]);
        return Right(data);
      } else {
        return Left(AppError.httpError);
      }
    }
   on SocketException catch (e){
     print(e);
      return Left(AppError.networkError);
    }
    catch (e){
      print(e);
      return Left(AppError.unknownError);
    }

  }
}
