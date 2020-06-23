import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:jobxprss_company/main_app/api_helpers/api_client.dart';
import 'package:jobxprss_company/main_app/api_helpers/urls.dart';
import 'package:jobxprss_company/main_app/auth_service/auth_service.dart';
import 'package:jobxprss_company/main_app/failure/app_error.dart';
import 'package:jobxprss_company/main_app/models/contact_us_model.dart';
import 'package:jobxprss_company/main_app/models/settings_model.dart';
import 'package:jobxprss_company/main_app/resource/strings_resource.dart';

class ContactUsSubmitRepository {
//  Future<Either<AppError, ContactUsModel>> getSettingInfo(
//      {ApiClient apiClient}) async {
//    var client = apiClient ?? ApiClient();
//
//    try{
//      var res = await client.getRequest(Urls.contactUsSubmitUrl);
//      print(res.statusCode);
//      if (res.statusCode == 200) {
//        var decodedJson = json.decode(res.body);
//        var data = ContactUsModel.fromJson(decodedJson[0]);
//        return Right(data);
//      } else {
//        return Left(AppError.httpError);
//      }
//    }
//    on SocketException catch (e){
//      print(e);
//      return Left(AppError.networkError);
//    }
//    catch (e){
//      print(e);
//      return Left(AppError.unknownError);
//    }
//
//  }

  Future<Either<AppError, bool>> addContactUsData(
      ContactUsModel contactUsModel) async {
    BotToast.showLoading();
    var url = "${Urls.contactUsSubmitUrl}";
    var data = contactUsModel.toJson();
    try {
      var response = await ApiClient().postRequest(url, data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      print(e);
      return left(AppError.serverError);
    }
  }


}
